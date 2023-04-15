import numpy as np
import pandas as pd
import tensorflow as tf
import tensorflow_hub as hub
import os

labels = pd.read_csv('labels.csv')
unique_labels = np.unique(labels["labels"])

# Define image size
IMG_SIZE = 224

# Create a function for preprocessing images
def process_image(image_path):
  """
  Takes an image file path and turns the image into a Tensor
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
def create_data_batches(X, y = None, batch_size = BATCH_SIZE, val_data = False, test_data = False):
  """
  Creates batches of data out of image (X) and label (y) pairs.
  Shuffles the data if it's training data but doesn't shuffle if it's validation data.
  Also accepts test data as input (No Labels)
  """
  # If the data is a test dataset, we don't have labels
  if test_data:
    print("Creating test data batches...")
    data = tf.data.Dataset.from_tensor_slices((tf.constant(X))) # Only filepaths, no labels (Makes dataset from slices of given tensor)
    data_batch = data.map(process_image).batch(BATCH_SIZE) # Creates batches of given batch size
    return data_batch

  # If the data is validation dataset, we don't need to shuffle it 
  elif val_data:
    print("Creating validation data batches...")
    data = tf.data.Dataset.from_tensor_slices((tf.constant(X),  # filepaths
                                               tf.constant(y))) # labels
    data_batch = data.map(get_image_label).batch(BATCH_SIZE)
    return data_batch

  else: # It's training data
    print("Creating training data batches...")
    # Turn filepaths and labels into tensors
    data = tf.data.Dataset.from_tensor_slices((tf.constant(X),
                                               tf.constant(y)))
    # Shuffling before preprocessing images is faster
    data = data.shuffle(buffer_size = len(X))

    # Create (image, label) tuples and preprocess the image
    data_batch = data.map(get_image_label).batch(BATCH_SIZE)
    return data_batch
  
# Turn prediction probabilities into their respective label (Easy To Understand)
def get_pred_label(prediction_probabilities):
  """
  Turns an array of prediction probabilities into a prediction label
  """
  return unique_labels[np.argmax(prediction_probabilities)]

# Create a function to load a trained model
def load_model(model_path):
  """
  Loads a saved model from a specified path
  """
  print(f"Loading Saved Model From: {model_path}")
  model = tf.keras.models.load_model(model_path,
                                     custom_objects = {"KerasLayer": hub.KerasLayer})
  return model

# Load in the saved model
model = load_model("model.h5")

# Get custom image filepaths (Change this path to the location where you saved the uploaded images from the app)
custom_path = "path/to/saved/images"
custom_image_paths = [custom_path + fname for fname in os.listdir(custom_path)]

# Turn custom images into batch datasets
custom_data = create_data_batches(custom_image_paths, test_data = True)

# Make predictions on the custom data
custom_preds= model.predict(custom_data)

# Get custom image prediction labels
custom_pred_labels = [get_pred_label(custom_preds[i]) for i in range(len(custom_preds))]