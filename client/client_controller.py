"""
    This file contains the functions for client application.
"""
import datetime
import os
import uuid
from flask import request
import client.client_db as db
import features
from authentication_system import getToken, client_authentication
from credentials import secret_key
from models_serializer import Login


@client_authentication
def set_alerts():
    payload = request.get_json()
    unique_id = set_alerts.payload.get("uniqueId")  # getting unique id by token authentication payload
    payload["alertId"] = uuid.uuid4().hex
    payload["timestamp"] = str(datetime.datetime.now())
    payload["readStatus"] = False
    # DB Function to add alert in db alerts array in offenders.
    if db.set_alerts_in_db(payload, unique_id):
        return {
            "status": True,
            "message": "alert uploaded successfully"
        }, 200
    return {
        "status": False,
        "message": "something went wrong"
    }, 500


def client_login():
    payload = request.get_json()
    try:
        Login().load(payload)
    except Exception as e:
        print(f"ERROR VALIDATION >>> {e}")
        return {
            "status": False,
            "message": "invalid input fields",
            "error": str(e)
        }, 422
    flag, data = db.login_user(payload)
    if flag:
        token = getToken(payload["email"], payload["password"], secret_key)
        return {
            "message": "success",
            "status": True,
            "token": token,
            "details": data
        }
    else:
        return {
            "message": "Invalid Credentials",
            "status": False
        }, 401


@client_authentication
def get_client_profile_details():
    try:
        unique_id = get_client_profile_details.payload.get("uniqueId")
        payload = db.get_client_profile(unique_id)
        if payload:
            return {
                "status": True,
                "details": payload
            }, 200

    except Exception as e:
        print(f"ERROR CLIENT PROFILE DETAILS >>>> {e}")
    return {
        "status": False,
        "message": "Something went wrong..."
    }, 500


@client_authentication
def update_client_profile_pic():
    offender_id = update_client_profile_pic.payload.get("uniqueId")
    try:
        if 'image' in request.files:
            image_path = f"static/offender_profiles/{offender_id}/profile_pic"
            if not os.path.exists(image_path):
                os.makedirs(image_path)
            file = request.files['image']
            filename = file.filename
            rename_file = features.file_rename(filename.split(".")[1], offender_id)  # function for renaming file.
            print(rename_file)
            file.save(os.path.join(image_path, rename_file))
            # DB Function to update user-profile and add image path in profile
            flag, image_url = db.upload_image_on_firebase_storage(offender_id,
                                                                  "Offenders",
                                                                  f"{image_path}/{rename_file}",
                                                                  "profilePic")
            if flag and image_url:
                # to remove images from local storage after saving in firebase cloud storage.
                os.remove(f"{image_path}/{rename_file}")
                # os.removedirs(image_path)
                return {
                    "status": True,
                    "message": "Signature saved successfully.",
                    "signature": f"{image_url}"
                }
            else:
                return {
                    "status": False,
                    "message": "Error Occurred"
                }, 500
        return {
            "status": False,
            "message": "image not found"
        }, 404
    except Exception as e:
        print(f"ERROR >>> {e}")
        return {
            "status": False,
            "message": "Error Occurred"
        }, 500


@client_authentication
def upload_document():
    offender_id = upload_document.payload.get("uniqueId")
    document_type = request.form.get("documentTitle", "document")
    document_description = request.form.get("description", "")
    try:
        if 'document' in request.files:
            image_path = f"static/offender_profiles/{offender_id}/documents"
            if not os.path.exists(image_path):
                os.makedirs(image_path)
            file = request.files['document']
            filename = file.filename
            rename_file = features.file_rename(filename.split(".")[1],
                                               f"{offender_id}_{document_type}")  # function for renaming file.
            print(rename_file)
            file.save(os.path.join(image_path, rename_file))
            # DB Function to update user-profile and add image path in profile
            flag, image_url = db.upload_document_on_storage(offender_id,
                                                            "Offenders",
                                                            f"{image_path}/{rename_file}",
                                                            "document", document_type, document_description)
            if flag and image_url:
                # to remove images from local storage after saving in firebase cloud storage.
                os.remove(f"{image_path}/{rename_file}")
                # os.removedirs(image_path)
                return {
                    "status": True,
                    "message": "Document saved successfully.",
                    "document": f"{image_url}"
                }
            else:
                return {
                    "status": False,
                    "message": "Error Occurred"
                }, 500
        return {
            "status": False,
            "message": "Document not found"
        }, 404
    except Exception as e:
        print(f"ERROR >>> {e}")
        return {
            "status": False,
            "message": "Error Occurred"
        }, 500


@client_authentication
def get_client_checkin_request():
    unique_id = get_client_checkin_request.payload.get("uniqueId")
    # DB function to get list of checkin requests.
    checkin_list = db.get_checkins(unique_id)
    return {
        "status": True,
        "details": checkin_list,
        "totalRequests": len(checkin_list)
    }


@client_authentication
def do_pin_checkin():
    payload = request.get_json()
    request_id = payload.get("requestId")
    unique_id = do_pin_checkin.payload.get("uniqueId")
    pin = payload.get("pin")
    # DB function to verify pin check-in
    status_code, request_data = db.pin_checkin(request_id, pin, unique_id)
    if status_code == 200:
        return {
            "status": True,
            "message": "Check-in Successful",
            "details": request_data
        }, status_code
    elif status_code == 401:
        return {
            "status": False,
            "message": "INVALID PIN"
        }, status_code
    return {
        "status": False,
        "message": "something went wrong"
    }, status_code


@client_authentication
def add_bracelet_logs():
    payload = request.get_json()
    connection_status = payload.get("connectionStatus")
    client_id = add_bracelet_logs.payload.get("uniqueId")
    # DB function for updating logs in offenders collection.
    if db.update_bracelet_logs(client_id, connection_status):
        return {
            "status": True,
            "message": "Log added successfully"
        }, 200
    return {
        "status": False,
        "message": "something went wrong..."
    }, 500


@client_authentication
def update_user_current_location():
    payload = request.get_json()
    user_id = update_user_current_location.payload.get("uniqueId", "")
    # db function to update user current coordinates.
    status_code = db.update_client_current_location(payload, user_id)
    if status_code == 200:
        return {
            "status": True,
            "message": "Coordinates updated successfully."
        }, status_code
    if status_code == 404:
        return {
            "status": False,
            "message": f"Client Not Found with ID: {user_id}"
        }, status_code
    return {
        "status": False,
        "message": "Something went wrong"
    }, status_code
