import pandas as pd
import numpy as np
from common_functions import load_model

# Check if all labels are unique
mri_labels = pd.read_csv("./data/mri/labels.csv")

unique_mri_labels = np.unique(mri_labels["labels"])
mri_labels = mri_labels["labels"]

# Turn every label into a boolean array (Compare with all classes and the only True value will be the class it belongs to)
mri_labels[0] == unique_mri_labels

# Do this for all labels

boolean_mri_labels = [label == unique_mri_labels for label in mri_labels]
boolean_mri_labels[:2]

mri_model = load_model("./data/mri/model.h5")

# Turn prediction probabilities into their respective label (Easy To Understand)
def get_mri_pred_label(prediction_probabilities):
  """
  Turns an array of prediction probabilities into a prediction label
  """
  if np.argmax(prediction_probabilities) > 0.5:
    return unique_mri_labels[np.argmax(prediction_probabilities)]
  else:
    return "MRI Scan Not Detected"