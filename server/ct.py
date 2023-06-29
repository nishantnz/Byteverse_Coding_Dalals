import pandas as pd
import numpy as np
from common_functions import load_model

ct_labels_csv = pd.read_csv("./data/ct/train.csv")

# Labels Dictionary
ct_labels_dict = { 0: "No_DR",
                1: "Mild",
                2: "Moderate",
                3: "Severe",
                4: "Proliferate_DR" }

ct_labels = ct_labels_csv["diagnosis"]
ct_labels = np.array(ct_labels) # We can also do : to_numpy()

unique_ct_categories = np.unique(ct_labels)
ct_labels[0] == unique_ct_categories

boolean_ct_labels = [label == unique_ct_categories for label in ct_labels]

ct_model = load_model("./data/ct/model.h5")

# Turn prediction probabilities into their respective label (Easy To Understand)
def get_ct_pred_label(prediction_probabilities):
  """
  Turns an array of prediction probabilities into a prediction label
  """
  if np.argmax(prediction_probabilities) > 0.5:
    return ct_labels_dict[unique_ct_categories[np.argmax(prediction_probabilities)]]
  else:
    return "CT Scan Not Detected"

