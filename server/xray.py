import pandas as pd
import numpy as np
from common_functions import load_model

# Check if all labels are unique
xray_test_labels = pd.read_csv('./data/xray/test_labels.csv')
unique_xray_test_labels = np.unique(xray_test_labels["labels"])

xray_test_labels = xray_test_labels["labels"]
xray_test_labels[0] == unique_xray_test_labels

boolean_xray_test_labels = [label == unique_xray_test_labels for label in xray_test_labels]

xray_model = load_model("./data/xray/model.h5")

# Turn prediction probabilities into their respective label (Easy To Understand)
def get_xray_pred_label(prediction_probabilities):
  """
  Turns an array of prediction probabilities into a prediction label
  """
  if np.argmax(prediction_probabilities) > 0.5:
    return unique_xray_test_labels[np.argmax(prediction_probabilities)]
  else:
    return "X-ray Not Detected"