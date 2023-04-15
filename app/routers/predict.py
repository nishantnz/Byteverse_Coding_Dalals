from pathlib import Path
import os

import shutil
from typing import Annotated
from fastapi import APIRouter, File, UploadFile, Depends
from routers.auth import get_current_user
from mlmodel.braintumor import create_data_batches, model, get_pred_label

router = APIRouter(prefix="/predict")


def save_upload_file(upload_file: UploadFile, user_id, destination: Path) -> None:
    try:
        processing_folder_path = destination / user_id / 'processing'
        processing_folder_path.mkdir(parents=True, exist_ok=True)
        newf = destination / user_id / 'processed'
        newf.mkdir(parents=True,exist_ok=True)
        file_path = processing_folder_path / upload_file.filename
        with file_path.open("wb") as buffer:
            shutil.copyfileobj(upload_file.file, buffer)
    finally:
        upload_file.file.close()


@router.post("/upload")
def identify_disease(files: Annotated[list[UploadFile], File(description="Can take mutiple uploaded files")], user=Depends(get_current_user)):
    
    user_id = user.user_id
    for file in files:
        save_upload_file(file, user_id, Path(
            f"{os.getcwd()}/app/storage"))
    custom_path = f"{os.getcwd()}/app/storage/{user_id}/processing"
    custom_image_paths = [custom_path +
                          fname for fname in os.listdir(custom_path)]
    # Turn custom images into batch datasets
    custom_data = create_data_batches(custom_image_paths, test_data=True)
    # Make predictions on the custom data
    custom_preds = model.predict(custom_data)
    # Get custom image prediction labels
    custom_pred_labels = [get_pred_label(
        custom_preds[i]) for i in range(len(custom_preds))]
    
    return custom_pred_labels
