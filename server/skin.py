# Import CSV
import pandas as pd
import numpy as np
from common_functions import load_model

skin_labels = pd.read_csv('./data/skin/labels.csv')
unique_skin_labels = np.unique(skin_labels["labels"])

skin_labels = skin_labels["labels"]
skin_labels[0] = unique_skin_labels

# Do this for all labels

boolean_skin_labels = [label == unique_skin_labels for label in skin_labels]

skin_model = load_model("./data/skin/model.h5")

# Turn prediction probabilities into their respective label (Easy To Understand)
def get_skin_pred_label(prediction_probabilities):
  """
  Turns an array of prediction probabilities into a prediction label
  """
  if np.argmax(prediction_probabilities) > 0.5:
    return unique_skin_labels[np.argmax(prediction_probabilities)]
  else:
    return "Skin Surface Not Detected"