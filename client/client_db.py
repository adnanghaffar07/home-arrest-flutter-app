import datetime

import pyrebase
from credentials import firebase_config
import features

# import firebase_admin
# from firebase_admin import credentials, auth

# firebase_admin library
# ************************************************************************************************************
# cred = credentials.Certificate("cred.json")  # loading JSON credentials file.
# firebase_admin.initialize_app(cred)  # initialization firebase application.
# ************************************************************************************************************

# pyrebase library.
# ************************************************************************************************************
firebase = pyrebase.initialize_app(firebase_config)
database = firebase.database()
auth2 = firebase.auth()
storage = firebase.storage()


# ************************************************************************************************************


def login_user(payload):
    email = payload.get("email")
    password = payload.get("password")
    try:
        auth2.sign_in_with_email_and_password(email, password)
        unique_id = features.get_unique_name_for_document(email)
        details = database.child("Offenders").child(unique_id).get().val()
        if details:
            details = dict(details)
            # payload = {
            #     "firstName": details.get("firstName"),
            #     "middleName": details.get("middleName"),
            #     "lastName": details.get("lastName"),
            #     "maidenName": details.get("maidenName"),
            #     "emailAddress": details.get("emailAddress"),
            #     "active": details.get("active"),
            #     "profilePic": details.get("profilePic"),
            #     "braceletConnection": details.get("braceletConnection"),
            #     "dateOfBirth": details.get("dateOfBirth"),
            #     "personalDetails": details.get("personalDetails"),
            #     "phoneNumber": details.get("phoneNumber"),
            #     "signature": details.get("signature"),
            #     "uniqueId": details.get("uniqueId"),
            # }
            return True, details
    except Exception as e:
        print(f"ERROR >>> {e}")
    return False, None


def get_client_profile(unique_id):
    try:
        details = database.child("Offenders").child(unique_id).get().val()
        if details:
            details = dict(details)
            payload = {
                "firstName": details.get("firstName"),
                "middleName": details.get("middleName"),
                "lastName": details.get("lastName"),
                "maidenName": details.get("maidenName"),
                "emailAddress": details.get("emailAddress"),
                "active": details.get("active"),
                "profilePic": details.get("profilePic"),
                "braceletConnection": details.get("braceletConnection"),
                "dateOfBirth": details.get("dateOfBirth"),
                "personalDetails": details.get("personalDetails"),
                "phoneNumber": details.get("phoneNumber"),
                "signature": details.get("signature"),
                "uniqueId": details.get("uniqueId"),
            }
            return payload
    except Exception as e:
        print(f"ERROR CLIENT PROFILE DB >>> {e}")
    return None


def upload_image_on_firebase_storage(user_name, document_name, image_path, field_name):
    """
    This function will add and update profile pic path. Image is stored on the machine where API
    is deployed and the path is being updated in the Firebase Realtime database.
    """
    try:
        unique_id = features.get_unique_name_for_document(user_name)
        image = storage.child(image_path).put(image_path)
        image = dict(image)
        image_url = storage.child(image_path).get_url(token=image.get("downloadTokens"))
        print(image_url)
        resp = database.child(document_name).child(unique_id).update({field_name: image_url})
        if resp:
            return True, image_url
    except Exception as e:
        print(f"PROFILE PIC EXCEPTION >>> {e}")
    return False, None


def upload_document_on_storage(user_name, document_name, document_path, field_name, document_type):
    try:
        unique_id = features.get_unique_name_for_document(user_name)
        doc = storage.child(document_path).put(document_path)
        doc = dict(doc)
        doc_url = storage.child(document_path).get_url(token=doc.get("downloadTokens"))
        print(doc_url)
        resp = database.child(document_name).child(unique_id).child(field_name).push({"documentUrl": doc_url,
                                                                                      "documentType": document_type
                                                                                      })
        if resp:
            return True, doc_url
    except Exception as e:
        print(f"PROFILE PIC EXCEPTION >>> {e}")
    return False, None


def set_alerts_in_db(payload, user_id):
    try:
        response = database.child("Alerts").child(user_id).push(payload)
        if response:
            return True
    except Exception as e:
        print(f"ERROR SETTING ALERTS >>> {e}")
    return False


def get_checkins(unique_id):
    checkin_list = []
    try:
        payload = database.child("Offenders").child(unique_id).child("checkInRequest").get().val()
        if payload:
            checkin_list = list(dict(payload).values())
            return checkin_list
    except Exception as e:
        print(f"GETTING CHECKIN ERROR >>> {e}")
    return checkin_list


def pin_checkin(request_id, pin, unique_id):
    try:
        payload = database.child("Offenders").child(unique_id).child("checkInRequest").get().val()
        if payload:
            payload = dict(payload)
            for key, checkin_request in payload.items():
                if checkin_request.get("requestId") == request_id:
                    if checkin_request.get("checkinPin") == pin:
                        checkin_request["status"] = True
                        checkin_request["checkInTime"] = str(datetime.datetime.now())
                        late_minutes, late_status = features.get_minutes_and_status(checkin_request.get("checkInTime", ""),
                                                                                    checkin_request.get("deadline", ""))
                        checkin_request["lateStatus"] = late_status
                        checkin_request["lateMinutes"] = late_minutes
                        database.child("Offenders").child(unique_id).child("checkInRequest").child(key).update(
                            checkin_request)
                        return 200, checkin_request
                    else:
                        print(checkin_request)
                        return 401
    except Exception as e:
        print(f"PIN CHECKIN ERROR >>>> {e}")
    return 500


def update_bracelet_logs(unique_id, connection_status):
    try:
        payload = {
            "braceletConnection": connection_status,
            "timeStamp": str(datetime.datetime.now()),
        }
        database.child("Offenders").child(unique_id).child("braceletHistory").push(payload)
        return True
    except Exception as e:
        print(f"ERROR BRACELET LOGS >>> {e}")
    return False
