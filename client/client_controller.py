"""
    This file contains the functions for client application.
"""
import datetime
import uuid
from flask import request
import client.client_db as db
from authentication_system import getToken, client_authentication

secret_key = "0F53127e42354ze38D4024a9e2789a24"


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
    status_code = db.pin_checkin(request_id, pin, unique_id)
    if status_code == 200:
        return {
            "status": True,
            "message": "Check-in Successful"
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
