import tensorflow as tf
import tensorflow_hub as hub

# Define image size
IMG_SIZE = 224
SKIN_IMG_SIZE = 480

# Create a function for preprocessing images
def process_image(image_path):
  """
  Takes an image and turns the image into a Tensor
  """
  # Read in an image file
  image = tf.io.read_file(image_path)

  # Turn the jpg image into a numerical tensor with three color channels (RGB)
  image = tf.image.decode_jpeg(image, channels = 3)

  # Convert the colour channel values from 0-255 values to 0-1 values (Image Representation Using Floating Points Needs 0-1 Values)
  image = tf.image.convert_image_dtype(image, tf.float32) # Normalization !

  # Resize our image to our desired size (224,224)
  image = tf.image.resize(image, size = [IMG_SIZE, IMG_SIZE])

  return image

# Create a function for preprocessing images
def process_skin_image(image_path):
  """
  Takes an image and turns the image into a Tensor
  """
  # Read in an image file
  image = tf.io.read_file(image_path)

  # Turn the jpg image into a numerical tensor with three color channels (RGB)
  image = tf.image.decode_jpeg(image, channels = 3)

  # Convert the colour channel values from 0-255 values to 0-1 values (Image Representation Using Floating Points Needs 0-1 Values)
  image = tf.image.convert_image_dtype(image, tf.float32) # Normalization !

  # Resize our image to our desired size (480,480)
  image = tf.image.resize(image, size = [SKIN_IMG_SIZE, SKIN_IMG_SIZE])

  return image

# Create a simple function to return a tuple (image, label)
def get_image_label(image_path, label):
  """
  Takes an image file path and the associated label
  Processes image and returns tuple of (image, label) 
  """
  image = process_image(image_path)
  return image, label

# Define the batch size, 32 is a good start
BATCH_SIZE = 32

# Create a function to turn our data into batches
def create_data_batches(X, batch_size = BATCH_SIZE):

  print("Creating test data batches...")
  data = tf.data.Dataset.from_tensor_slices((tf.constant(X))) # Only filepaths, no labels (Makes dataset from slices of given tensor)
  data_batch = data.map(process_image).batch(BATCH_SIZE) # Creates batches of given batch size
  return data_batch

# Create a function to turn our data into batches
def create_skin_data_batches(X, batch_size = BATCH_SIZE):

  print("Creating test data batches...")
  data = tf.data.Dataset.from_tensor_slices((tf.constant(X))) # Only filepaths, no labels (Makes dataset from slices of given tensor)
  data_batch = data.map(process_skin_image).batch(BATCH_SIZE) # Creates batches of given batch size
  return data_batch

# Create a function to load a trained model
def load_model(model_path):
  """
  Loads a saved model from a specified path
  """
  print(f"Loading Saved Model From: {model_path}")
  model = tf.keras.models.load_model(model_path,
                                     custom_objects = {"KerasLayer": hub.KerasLayer})
  return model