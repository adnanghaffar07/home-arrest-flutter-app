import os
import features
from models_serializer import UserSerializer, Login
import firebase_db_controller as db
from authentication_system import getToken, authentication

secret_key = "0F53127e42354ze38D4024a9e2789a24"


def sign_up(request):
    payload = request.get_json()
    try:
        UserSerializer().load(payload)
    except Exception as e:
        print(f"ERROR VALIDATION >>> {e}")
        return {
            "status": False,
            "message": "invalid input fields",
            "error": e
        }, 422
    role_list = [1, 2, 3]
    role_status = int(request.get_json().get("role"))
    if role_status not in role_list:
        return {
            "status": False,
            "message": "Invalid role selected."
        }, 500
    # register_user is array declared globally to save users for demo.
    payload["location"] = payload.get("location", {})
    payload["userName"] = payload.get("firstName", "") + " " + payload.get("lastName", "")
    payload["clientsAssigned"] = []
    payload["profilePic"] = ""
    payload["signature"] = ""
    payload["address1"] = ""
    payload["address2"] = ""
    payload["country"] = ""
    payload["state"] = ""
    payload["dailyReport"] = True
    payload["notifications"] = {
        "authentication": {
            "email": True,
            "pushNotification": True
        },
        "braceletConnection": {
            "email": True,
            "pushNotification": True
        },
        "braceletBattery": {
            "email": True,
            "pushNotification": True
        },
        "exclusionZone": {
            "email": True,
            "pushNotification": True
        },
        "gpsLocation": {
            "email": True,
            "pushNotification": True
        },
        "missing": {
            "email": True,
            "pushNotification": True
        },
        "noReply": {
            "email": True,
            "pushNotification": True
        },
        "outsideZone": {
            "email": True,
            "pushNotification": True
        },
        "phoneBattery": {
            "email": True,
            "pushNotification": True
        },
        "sobriety": {
            "email": True,
            "pushNotification": True
        }
    }
    passwd = payload.get("password")
    if payload.get("role") == 1:
        payload["roleName"] = "super user"
    elif payload.get("role") == 2:
        payload["roleName"] = "super admin"
    elif payload.get("role") == 3:
        payload["roleName"] = "admin"
    if len(payload.get("password", "")) < 6:
        return {
            "status": False,
            "message": "Password is too short. Characters must be >=6."
        }, 500
    flag, status_code = db.register_user(payload)

    if flag:
        token = getToken(payload["email"], passwd, secret_key)
        return {
            "message": "Account Created Successfully",
            "status": True,
            "token": token
        }, 201
    return {
        "message": f"User already exists with E-mail: {payload.get('email')}",
        "status": False,
    }, 403


def log_in(request):
    payload = request.get_json()
    try:
        Login().load(payload)
    except Exception as e:
        print(f"ERROR VALIDATION >>> {e}")
        return {
            "status": False,
            "message": "invalid input fields",
            "error": e
        }, 422
    print(payload)
    if len(payload.get("password", "")) < 6:
        return {
            "status": False,
            "message": "Password is too short. Characters must be >=6."
        }, 500
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


@authentication
def update_profile(request):
    payload = request.get_json()
    try:
        UserSerializer().load(payload)
    except Exception as e:
        print(f"ERROR VALIDATION >>> {e}")
        return {
            "status": False,
            "message": "invalid input fields",
            "error": e
        }, 422
    unique_id = update_profile.payload.get("uniqueId")
    # DB function to update user profile details.
    resp = db.update_user_profile_details(payload, unique_id)
    if resp:
        return {
            "status": True,
            "message": "Profile Updated Successfully"
        }
    else:
        return {
            "status": False,
            "message": "Something went wrong"
        }


@authentication
def update_password(request):
    payload = request.get_json()
    email = update_password.payload.get("email")
    resp = db.update_user_password(email, payload.get("newPassword"))
    if resp:
        token = getToken(email, payload.get("newPassword"), secret_key)
        return {
            "status": True,
            "token": token
        }
    else:
        return {
            "status": False,
            "message": "Something went wrong"
        }


@authentication
def get_profile_details(request):
    email = get_profile_details.payload.get("email")
    # db function to get profile details.
    payload = db.get_profile_details(email)
    if payload:
        return {
            "status": True,
            "message": "user found",
            "details": payload
        }
    return {
        "status": False,
        "message": "something went wrong"
    }, 500


@authentication
def get_super_admin_list(request):
    # DB function to get list of users with role=2
    try:
        users = db.get_admin_by_role_id(2)
        print(users)
        return {
            "status": True,
            "details": users
        }
    except Exception as e:
        print(f"ERROR ADMIN LIST >>> {e}")
    return {
        "status": False,
        "message": "Something went wrong"
    }, 500


@authentication
def get_admin_list(request):
    # DB function to get list of users with role=3
    try:
        users = db.get_admin_by_role_id(3)
        print(users)
        return {
            "status": True,
            "details": users
        }
    except Exception as e:
        print(f"ERROR ADMIN LIST >>> {e}")
    return {
        "status": False,
        "message": "Something went wrong"
    }, 500


@authentication
def change_role(request):
    role_list = [1, 2, 3]
    admin_id = request.args.to_dict().get("adminId")
    role_status = int(request.args.to_dict().get("roleStatus"))
    if role_status not in role_list:
        return {
            "status": False,
            "message": "Invalid role selected."
        }, 500
    permission_access = change_role.payload.get("role")
    if permission_access != 1:
        return {
            "status": False,
            "message": "Permission Denied"
        }, 401
    else:
        # DB function to update role status of provided admin ID.
        if db.update_admin_role(admin_id, role_status):
            return {
                "status": True,
                "message": "Status updated successfully..."
            }
    return {
        "status": False,
        "message": "something went wrong..."
    }, 500


@authentication
def upload_profile_pic(request):
    user_name = upload_profile_pic.payload.get("email")
    role_code = upload_profile_pic.payload.get("role")
    # Checking for Logged-in user role. Assigning folder according to user's type.
    if role_code == 1:
        user_type = "su"
    elif role_code == 2:
        user_type = "sa"
    elif role_code == 3:
        user_type = "admin"
    else:  # Condition will return if user role is not in between 1-3.
        return {
            "status": False,
            "message": "The user that is logged in contains the type which is not registered. kindly check what's wrong."
        }, 401
    try:
        if 'image' in request.files:
            image_path = f"static/profiles/{user_type}/{user_name}/profile-pic"
            if not os.path.exists(image_path):
                os.makedirs(image_path)
            file = request.files['image']
            filename = file.filename
            rename_file = features.file_rename(filename.split(".")[1], user_name)  # function for renaming file.
            print(rename_file)
            file.save(os.path.join(image_path, rename_file))
            # DB Function to update user-profile and add image path in profile
            flag, image_url = db.upload_image_on_firebase_storage(user_name, "Users",
                                                                  f"{image_path}/{rename_file}",
                                                                  "profilePic")
            if flag and image_url:
                # to remove images from local storage after saving in firebase cloud storage.
                os.remove(f"{image_path}/{rename_file}")
                # os.removedirs(image_path)
                return {
                    "status": True,
                    "message": "profile saved successfully.",
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


@authentication
def get_users_by_query(request):
    query = request.args.to_dict().get("query")
    print(query)
    # db function to perform query search.
    results = db.user_search_by_query(query)
    return {
        "status": True,
        "details": results,
        "totalResults": len(results)
    }


@authentication
def update_user_current_location(request):
    payload = request.get_json()
    user_id = update_user_current_location.payload.get("uniqueId", "")
    # db function to update user current coordinates.
    status_code = db.update_user_current_location(payload, user_id)
    if status_code == 200:
        return {
            "status": True,
            "message": "Coordinates updated successfully."
        }, status_code
    if status_code == 404:
        return {
            "status": False,
            "message": f"User Not Found with ID: {user_id}"
        }, status_code
    return {
        "status": False,
        "message": "Something went wrong"
    }, status_code


@authentication
def request_checkin(request):
    payload = request.get_json()
    offender_id = payload.get("offenderId")
    del payload["offenderId"]  # to remove field from payload.
    agent_id = request_checkin.payload.get("uniqueId", "")
    # db function to add request checkin in the db
    status_code, response = db.add_request_checkin(payload, agent_id, offender_id)
    if status_code == 200:
        return {
            "status": True,
            "message": "request sent successfully...",
            "details": response
        }, status_code
    return {
        "status": False,
        "message": "something went wrong...",
        "details": response
    }, status_code


@authentication
def upload_signature(request):
    user_name = upload_signature.payload.get("email")
    role_code = upload_signature.payload.get("role")
    # Checking for Logged-in user role. Assigning folder according to user's type.
    if role_code == 1:
        user_type = "su"
    elif role_code == 2:
        user_type = "sa"
    elif role_code == 3:
        user_type = "admin"
    else:  # Condition will return if user role is not in between 1-3.
        return {
            "status": False,
            "message": "The user that is logged in contains the user-type which is not registered. kindly check what's wrong."
        }, 401
    try:
        if 'image' in request.files:
            image_path = f"static/profiles/{user_type}/{user_name}/signature"
            if not os.path.exists(image_path):
                os.makedirs(image_path)
            file = request.files['image']
            filename = file.filename
            rename_file = features.file_rename(filename.split(".")[1], user_name)  # function for renaming file.
            print(rename_file)
            file.save(os.path.join(image_path, rename_file))
            # DB Function to update user-profile and add image path in profile
            flag, image_url = db.upload_image_on_firebase_storage(user_name,
                                                                  "Users",
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
def get_alerts(request):
    offenders_list = get_alerts.payload.get("clientsAssigned")
    # print(offenders_list)
    # db function to get the list of alerts
    if offenders_list:
        payload = db.get_alerts_from_db(offenders_list)
        return {
            "status": True,
            "alerts": payload,
            "totalAlerts": len(payload)
        }


def change_alert_status(request):
    alert_id = request.args.to_dict().get("alertId")
    unique_id = request.args.to_dict().get("uniqueId")
    # db function to change read status
    if db.change_alert_read_status(alert_id, unique_id):
        return {
            "status": True,
            "message": "Alert read successfully..."
        }
    return {
        "status": False,
        "message": "something went wrong..."
    }, 500
