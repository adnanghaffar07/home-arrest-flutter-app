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
    return {
        "status": True,
        "totalResults": len(offenders),
        "details": offenders
    }


@authentication
def add_new_offender(request):
    # if add_new_offender.payload.get("role") != 1:
    #     return {
    #         "status": False,
    #         "message": "Permission Denied."
    #     }, 401
    payload = request.get_json()
    # Validation of response.
    try:
        OffenderSerializer().load(payload)
    except Exception as e:
        print(f"ERROR VALIDATION >>> {e}")
        return {
            "status": False,
            "message": "invalid Fields."
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
    offender.recentAlerts = payload.get("recentAlerts", offender.recentAlerts)
    offender.courtAppearances = payload.get("courtAppearances", offender.courtAppearances)
    offender.checkInDetails = payload.get("checkInDetails", offender.checkInDetails)
    offender.pinNumber = offender.pinNumber
    offender.braceletName = offender.braceletName
    offender.braceletVersion = offender.braceletVersion
    offender.breathalyzer = offender.breathalyzer
    offender.allDocumentPresent = offender.allDocumentPresent
    offender.absconded = offender.absconded
    offender.appearanceDate = offender.appearanceDate
    offender.appearanceTime = offender.appearanceTime
    offender.specialInstructions = offender.specialInstructions
    offender.monitoringInformation = offender.monitoringInformation
    offender.monitoringFrequency = offender.monitoringFrequency
    offender.monitorTime = offender.monitorTime
    offender.photoCheckIn = offender.photoCheckIn
    offender.videoCheckIn = offender.videoCheckIn
    offender.sobrietyCheckIn = offender.sobrietyCheckIn
    offender.requiredTimesCheckIn = offender.requiredTimesCheckIn
    offender.mainScheduleOnly = offender.mainScheduleOnly
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
            "message": "invalid Fields."
        }, 422
    # DB Function to update details.
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
