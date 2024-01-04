import os
from datetime import datetime

import features
import firebase_db_controller as db
from authentication_system import authentication
from models import Offender
from models_serializer import OffenderSerializer

"""
                            ********** OFFENDER CONTROLLER **********
            
        This file contains the function related to offenders. The end-point function is in main file and the
        functionalities are being handled in this file.
"""


@authentication
def get_offenders(request):
    # payload = request.args.to_dict()
    # db function to get all offenders array
    user_id = get_offenders.payload.get("email")
    offenders = db.get_offenders_details_list(user_id)
    offenders = features.sort_by_dict_keys(offenders, "monitorLevel")[::-1]
    return {
        "status": True,
        "totalResults": len(offenders),
        "details": offenders
    }


@authentication
def add_new_offender(request):
    payload = request.get_json()
    # Validation of response.
    try:
        OffenderSerializer().load(payload)
    except Exception as e:
        print(f"ERROR VALIDATION >>> {e}")
        return {
            "status": False,
            "message": "invalid Fields.",
            "error": str(e)
        }, 422
    # this part of code assigning default values and handle null or missing fields.
    offender = Offender()
    offender.uniqueId = features.get_unique_name_for_document(payload.get("emailAddress", ""))
    offender.clientType = payload.get("clientType")
    offender.firstName = payload.get("firstName")
    offender.middleName = payload.get("middleName")
    offender.lastName = payload.get("lastName")
    offender.maidenName = payload.get("maidenName")
    offender.dateOfBirth = payload.get("dateOfBirth")
    offender.ssn = payload.get("ssn")
    offender.phoneNumber = payload.get("phoneNumber")
    offender.emailAddress = payload.get("emailAddress")
    offender.sentenceStartDate = payload.get("sentenceStartDate")
    offender.sentenceEndDate = payload.get("sentenceEndDate")
    offender.checkIn = payload.get("checkIn")
    offender.monitorLevel = payload.get("monitorLevel")
    offender.profilePic = ""
    offender.location = payload.get("location", offender.location)
    offender.agentAssigned = payload.get("agentAssigned", add_new_offender.payload.get("email", ""))
    offender.active = payload.get("active", "active")
    offender.dateOfEntry = str(datetime.now())
    offender.addedBy = add_new_offender.payload.get("email", "")
    offender.scoreCard = payload.get("scoreCard", offender.scoreCard)
    offender.signature = ""
    offender.profilePic = ""
    offender.recentAlerts = payload.get("recentAlerts", offender.recentAlerts)
    offender.courtAppearances = payload.get("courtAppearances", offender.courtAppearances)
    offender.checkInRequest = payload.get("checkInRequest", {})
    offender.pinNumber = offender.pinNumber
    offender.paymentHistory = offender.paymentHistory
    offender.mainScheduleDetails = offender.mainScheduleDetails
    offender.offenceDetails = offender.offenceDetails
    offender.braceletName = offender.braceletName
    offender.braceletVersion = offender.braceletVersion
    offender.breathalyzer = offender.breathalyzer
    offender.allDocumentPresent = offender.allDocumentPresent
    offender.absconded = offender.absconded
    offender.appearanceDate = offender.appearanceDate
    offender.appearanceTime = offender.appearanceTime
    offender.specialInstructions = offender.specialInstructions
    offender.monitoringInformation = offender.monitoringInformation
    # offender.monitoringFrequency = offender.monitoringFrequency
    # offender.monitorTime = offender.monitorTime
    # offender.photoCheckIn = offender.photoCheckIn
    # offender.videoCheckIn = offender.videoCheckIn
    # offender.sobrietyCheckIn = offender.sobrietyCheckIn
    offender.requiredTimesCheckIn = offender.requiredTimesCheckIn
    # offender.mainScheduleOnly = offender.mainScheduleOnly
    offender.contactDetails = offender.contactDetails
    offender.workDetails = offender.workDetails
    offender.personalDetails = offender.personalDetails
    offender.billingDetails = offender.billingDetails
    offender.guarantors = offender.guarantors
    offender.braceletConnection = payload.get("braceletConnection", False)

    client = offender.__dict__
    code = db.add_offender_client(client)
    if code == 403:
        return {
            "status": False,
            "message": f"Entry already exists with E-mail: {offender.emailAddress}"
        }, 403
    elif code == 201:
        return {
            "status": True,
            "message": "client added successfully",
            "details": client
        }, 201
    else:
        return {
            "status": False,
            "message": "Something went wrong"
        }, 500


@authentication
def get_single_offender(request):
    payload = request.args.to_dict()
    client_id = payload.get("id")
    # db function to get all offenders array
    offender = db.get_offender_details(client_id)
    if offender:
        return {
            "status": True,
            "details": offender
        }
    return {
        "status": False,
        "message": "Not Found"
    }, 404


@authentication
def update_offender_info(request):
    payload = request.get_json()
    try:
        OffenderSerializer().load(payload)
    except Exception as e:
        print(f"ERROR VALIDATION >>> {e}")
        return {
            "status": False,
            "message": "invalid Fields.",
            "error": str(e)
        }, 422
    # DB Function to update details.
    if not payload.get("uniqueId"):
        return {
            "status": False,
            "message": "Offender not found. offender ID missing in payload."
        }, 404
    data = db.update_offender_client_info(payload)
    if data:
        return {
            "status": True,
            "message": "Details updated successfully"
        }
    else:
        return {
            "status": False,
            "message": "Something went wrong"
        }, 500


@authentication
def get_active_offenders(request):
    try:
        offenders = db.get_offenders_by_status("active")
        return {
            "status": True,
            "details": offenders,
            "totalResults": len(offenders)
        }
    except Exception as e:
        print(f"ERROR >>> {e}")
    return {
        "status": False,
        "message": "Something went wrong..."
    }, 500


@authentication
def get_pending_offenders(request):
    try:
        offenders = db.get_offenders_by_status("pending")
        return {
            "status": True,
            "details": offenders,
            "totalResults": len(offenders)
        }
    except Exception as e:
        print(f"ERROR >>> {e}")
    return {
        "status": False,
        "message": "Something went wrong..."
    }, 500


@authentication
def get_offender_location(request):
    offender_id = request.args.to_dict().get("id")
    # db function to get current location of the offender.
    location, status = db.get_offender_current_location(offender_id)
    if status == 200 and location != "NA":
        return {
            "status": True,
            "message": "location found",
            "location": location
        }, status
    elif location == "NA":
        return {
            "status": False,
            "message": "location unavailable"
        }, status
    return {
        "status": False,
        "message": "Client not found"
    }, status


@authentication
def get_offenders_by_query(request):
    query = request.args.to_dict().get("query")
    agent_id = get_offenders_by_query.payload.get("email")
    print(query)
    # db function to perform query search.
    results = db.offender_search_by_query(query, agent_id)
    return {
        "status": True,
        "details": results,
        "totalResults": len(results)
    }


@authentication
def update_offender_profile_pic(request):
    offender_id = request.form.get("uniqueId")
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
                    "message": "profile pic saved successfully.",
                    "profilePic": f"{image_url}"
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


def update_offender_signature(request):
    offender_id = request.form.get("uniqueId")
    try:
        if 'image' in request.files:
            image_path = f"static/offender_profiles/{offender_id}/signature"
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
                                                                  "signature")
            if flag and image_url:
                # to remove images from local storage after saving in firebase cloud storage.
                os.remove(f"{image_path}/{rename_file}")
                # os.removedirs(image_path)
                return {
                    "status": True,
                    "message": "profile pic saved successfully.",
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


@authentication
def get_checkin_history(request):
    client_id = request.args.to_dict().get("offenderId")
    # db function to get history of clients assigned
    data = db.get_checkin_history(client_id)
    return {
        "status": True,
        "details": data,
    }, 200


@authentication
def get_bracelet_history(request):
    offender_id = request.args.to_dict().get("offenderId")
    # db function to get the history of bracelet connection status.
    results = db.bracelet_history_logs(offender_id)
    return {
        "status": True,
        "details": results,
        "totalResults": len(results)
    }, 200


@authentication
def add_new_trip(request):
    payload = request.get_json()
    # DB Function to add trip details in the DB.
    flag, payload = db.add_trip_details(payload)
    if flag:
        return {
            "status": True,
            "message": "Trip set successfully.",
            "details": payload
        }
    return {
        "status": False,
        "message": "something went wrong."
    }, 500


@authentication
def get_trip_history(request):
    agent_id = request.args.to_dict().get("clientId", "")
    # db function to get clients location history or trip history.
    results = db.get_location_history(agent_id)
    return {
        "status": True,
        "details": results
    }
