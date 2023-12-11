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
        details = dict(database.child("Offenders").child(unique_id).get().val())
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
                        database.child("Offenders").child(unique_id).child("checkInRequest").child(key).update(checkin_request)
                        return 200
                    else:
                        print(checkin_request)
                        return 401
    except Exception as e:
        print(f"PIN CHECKIN ERROR >>>> {e}")
    return 500
