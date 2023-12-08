"""
    This file contains the functions for client application.
"""
import datetime
import uuid
import firebase_db_controller as db
from flask import request


def set_alerts():
    payload = request.get_json()
    unique_id = payload.get("uniqueId")
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
