from flask_cors import CORS
from flask import Flask, request
from models import Offender
import features
from authentication_system import *
import firebase_db_controller as db

app = Flask(__name__)

app.config["SECRET_KEY"] = '0F53127e42354ze38D4024a9e2789a24'  # generated secret key for token generation

cors = CORS(app)


def authentication(func):
    """
    This decorator is for token authentication.
    :param func:
    :return:
    """
    def authenticate(*args, **kwargs):
        try:
            try:
                token = request.authorization.token
            except Exception as e:
                print(f"ERR ---- {e}")
                return {
                    "message": "Token Not Found",
                    "status": False
                }
            # print({"token": token})
            # print(token)
            payload = verify(token, app.config["SECRET_KEY"])  # Function to verify token.
            if payload:
                flag, data = db.login_user(
                    payload)  # if token verified, then it will use the signature containing user
                # credentials and get user-details
                if flag:
                    # print(payload)
                    authenticate.payload = data
                    return func(*args, **kwargs)
                else:
                    return {
                        "message": "Invalid Credentials",
                        "status": False
                    }, 401
            else:
                return {
                    "message": "invalid token",
                    "status": False
                }, 401
        except Exception as e:
            print(f"LOGIN ERROR >>> {e}")
            return {
                "message": "Error Occurred.",
                "status": False
            }

    # to use the authentication decorator on multiple functions. it will rename the authenticate function.
    authenticate.__name__ = func.__name__
    return authenticate


@app.route("/", methods=["GET"])
def index():
    """
    API Functioning testing endpoint.
    :return:
    """
    print("Index Page Hit")
    payload = {
        "name": "Adnan Ghaffar",
        "designation": "CEO CodeAutomation",
        "company": "CodeAutomation"
    }
    return payload


@app.errorhandler(404)
def not_found_error(e):
    print(e)
    return {
        "status": False,
        "message": "End-point does not exist."
    }, 404


@app.errorhandler(500)
def server_error(e):
    print(e)
    return {
        "status": False,
        "message": "Server Error Occurred."
    }, 500


@app.errorhandler(400)
def bad_request_error(e):
    print(e)
    return {
        "status": False,
        "message": "BAD REQUEST"
    }, 400


@app.route("/sign-up", methods=["POST"])
def sign_up():
    """
    Function will receive user information in order to create account and then save it.
    :return:
    """
    payload = request.get_json()
    # register_user is array declared globally to save users for demo.
    payload["location"] = payload.get("location", {})
    payload["userName"] = payload.get("firstName", "") + " " + payload.get("lastName", "")
    payload["clientsAssigned"] = []
    flag, status_code = db.register_user(payload)
    if flag:
        token = getToken(payload["email"], payload["password"], app.config["SECRET_KEY"])
        return {
            "message": "Account Created Successfully",
            "status": True,
            "token": token
        }
    return {
        "message": "User already exists with same email or phone number",
        "status": False,
    }


@app.route("/log-in", methods=["POST"])
def log_in():
    """
    The function will receive user credentials and then return response.
    response will contain user details.
    :return:
    """
    payload = request.get_json()
    print(payload)

    flag, data = db.login_user(payload)
    if flag:
        token = getToken(payload["email"], payload["password"], app.config["SECRET_KEY"])
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


@app.route("/user/update-profile", methods=["POST"])
@authentication
def update_profile():
    """
    This end-point will update user profile details.
    """
    payload = request.get_json()
    email = update_profile.payload.get("email")
    # DB function to update user profile details.
    resp = db.update_user_profile_details(payload, email)
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


@app.route("/clients/new-offender", methods=["POST"])
@authentication
def add_new_offender():
    """
    this end-point will add new offender in the database.
    """
    payload = request.get_json()
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
    offender.location = payload.get("location", {})
    offender.agentAssigned = payload.get("agentAssigned", "")
    offender.active = True
    offender.dateOfEntry = str(datetime.now())
    offender.addedBy = add_new_offender.payload.get("email", "")
    offender.scoreCard = payload.get("scoreCard", offender.scoreCard)
    offender.recentAlerts = payload.get("recentAlerts", offender.recentAlerts)
    offender.courtAppearances = payload.get("courtAppearances", offender.courtAppearances)
    client = offender.__dict__
    if db.add_offender_client(client):
        return {
            "status": True,
            "message": "client added successfully",
            "details": client
        }
    else:
        return {
            "status": False,
            "message": "Something went wrong"
        }, 500


@app.route("/clients/get-offenders", methods=["GET"])
@authentication
def get_offenders():
    """
    return the list of all the offenders added in the database.
    """
    # payload = request.args.to_dict()
    # db function to get all offenders array
    offenders = db.get_offenders_details_list()
    return {
        "status": True,
        "totalResults": len(offenders),
        "details": offenders
    }


@app.route("/clients/offenders/offender", methods=["GET"])
@authentication
def get_single_offenders():
    """
    The end-point will receive the id of the offender's profile and then
    return the details of the offender WRT id.
    """
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


@app.route("/clients/offender/update-offender-info", methods=["POST"])
@authentication
def update_offender_info():
    """
        End-Point for updating Offender information.
    """
    payload = request.get_json()
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


@app.route("/user/update-password", methods=["POST"])
@authentication
def update_password():
    payload = request.get_json()
    email = update_password.payload.get("email")
    old_password = payload.get("oldPassword")
    compare_pass = update_password.payload.get("password")
    if old_password != compare_pass:
        return {
            "status": False,
            "message": "Password did not match."
        }, 401
    # DB function to update new password.
    resp = db.update_user_password(email, payload.get("newPassword"))
    if resp:
        token = getToken(email, payload.get("newPassword"), app.config["SECRET_KEY"])
        return {
            "status": True,
            "token": token
        }
    else:
        return {
            "status": False,
            "message": "Something went wrong"
        }


@app.route("/user/profile", methods=["GET"])
@authentication
def get_profile_details():
    """
    Returns the details of logged-in user profile.
    """
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


@app.route("/user/super-admin-list", methods=["GET"])
@authentication
def get_super_admin_list():
    """
    This function will return list of users with role=2.
    """
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


@app.route("/user/admin-list", methods=["GET"])
@authentication
def get_admin_list():
    """
    This function will return list of users with role=3.
    """
    # DB function to get list of users with role=2
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


@app.route("/user/change-role", methods=["GET"])
@authentication
def change_role():
    admin_id = request.args.to_dict().get("adminId")
    role_status = request.args.to_dict().get("roleStatus")
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


@app.route("/clients/offenders/active", methods=["GET"])
@authentication
def get_active_offenders():
    """
    Function will return offenders with active status
    """
    try:
        offenders = db.get_active_offenders()
        return {
            "status": True,
            "details": offenders
        }
    except Exception as e:
        print(f"ERROR >>> {e}")
    return {
        "status": False,
        "message": "Something went wrong..."
    }, 500


if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0", port=5000, threaded=True)
