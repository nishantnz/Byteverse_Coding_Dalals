from flask import Flask, request
from flask_ngrok import run_with_ngrok
from werkzeug.utils import secure_filename
from common_functions import create_data_batches
from mri import mri_model, get_mri_pred_label
from xray import xray_model, get_xray_pred_label
from ct import ct_model, get_ct_pred_label
import os

UPLOAD_FOLDER = "../static/uploads"

app = Flask(__name__)
run_with_ngrok(app)  # Start ngrok when app is run
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

@app.route("/")
def hello_world():
  return ("Hello World!")

@app.route("/mri", methods = ["GET","POST"])
def mri_prediction():
    file = request.files['file']
    filename = secure_filename(file.filename)
    save_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
    file.save(save_path)
    image_path = [save_path]
    image = create_data_batches(image_path)
    prediction = mri_model.predict(image)
    pred_label = [get_mri_pred_label(prediction)]
    result = pred_label[0].replace("_"," ").title()
    return result

@app.route("/xray", methods = ["GET","POST"])
def xray_prediction():
    file = request.files['file']
    filename = secure_filename(file.filename)
    save_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
    file.save(save_path)
    image_path = [save_path]
    image = create_data_batches(image_path)
    prediction = xray_model.predict(image)
    pred_label = [get_xray_pred_label(prediction)]
    result = pred_label[0].replace("_"," ").title()
    return result

@app.route("/ct", methods = ["GET","POST"])
def ct_prediction():
    file = request.files['file']
    filename = secure_filename(file.filename)
    save_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
    file.save(save_path)
    image_path = [save_path]
    image = create_data_batches(image_path)
    prediction = ct_model.predict(image)
    pred_label = [get_ct_pred_label(prediction)]
    result = pred_label[0].replace("_"," ").title()
    return result

if __name__ == "__main__":
    #app.run(debug = True)
    app.run(host='0.0.0.0')