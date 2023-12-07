from flask_cors import CORS
from flask import Flask, request
import agent_controller
import offender_controller
from authentication_system import *
from flask_smorest import Blueprint

app = Flask(__name__)

app.config["SECRET_KEY"] = '0F53127e42354ze38D4024a9e2789a24'  # generated secret key for token generation
cors = CORS(app)

blp = Blueprint("validation", __name__, description="Model Validations")


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
    return agent_controller.sign_up(request)


@app.route("/log-in", methods=["POST"])
def log_in():
    """
    The function will receive user credentials and then return response.
    response will contain user details.
    :return:
    """
    return agent_controller.log_in(request)


@app.route("/user/update-profile", methods=["POST"])
def update_profile():
    """
    This end-point will update user profile details.
    """
    return agent_controller.update_profile(request)


@app.route("/user/update-password", methods=["POST"])
def update_password():
    """
    End-point for updating password. The function will take two parameters i.e., old password and new password.
    Then after checking old password with the password that the token provided, if valid will update new password.
    Otherwise, it will throw an error.
    """
    return agent_controller.update_password(request)


@app.route("/user/profile", methods=["GET"])
def get_profile_details():
    """
    Returns the details of logged-in user profile.
    """
    return agent_controller.get_profile_details(request)


@app.route("/user/super-admin-list", methods=["GET"])
def get_super_admin_list():
    """
    This function will return list of users with role=2.
    """
    return agent_controller.get_super_admin_list(request)


@app.route("/user/admin-list", methods=["GET"])
def get_admin_list():
    """
    This function will return list of users with role=3.
    """
    return agent_controller.get_admin_list(request)


@app.route("/user/change-role", methods=["GET"])
def change_role():
    """
    End-Point to change the role of the Admin.
    1- Super User
    2- Super Admin
    3- Admin
    """
    return agent_controller.change_role(request)


@app.route("/user/profile/profile-pic", methods=["POST", "GET"])
def upload_profile_pic():
    """
    This end-point is for uploading profile pic. Function will receive profile pic in the content-type of
    multipart/form-data.
    :return:
    """
    return agent_controller.upload_profile_pic(request)


@app.route("/users/search", methods=["GET"])
def get_users_by_query():
    """
    Search function for searching user based on first name, last name etc.
    """
    return agent_controller.get_users_by_query(request)


@app.route("/user/update-location", methods=["POST"])
def update_user_current_location():
    """
    This end-point will receive user's current location and update in the db.
    """
    return agent_controller.update_user_current_location(request)


@app.route("/user/request-checkin", methods=["POST"])
def request_checkin():
    """
    this end-point will add request in the db of the offender.
    """
    return agent_controller.request_checkin(request)


@app.route("/user/add-signature", methods=["POST"])
def add_signature():
    """
    this function will receive signature image and save it in the firebase storage.
    """
    return agent_controller.upload_signature(request)


# *********************************** Offender End-points***********************************************
@app.route("/clients/new-offender", methods=["POST"])
def add_new_offender():
    """
    this end-point will add new offender in the database.
    """
    return offender_controller.add_new_offender(request)


@app.route("/clients/get-offenders", methods=["GET"])
def get_offenders():
    """
    return the list of all the offenders added in the database.
    """
    return offender_controller.get_offenders(request)


@app.route("/clients/offenders/offender", methods=["GET"])
def get_single_offender():
    """
    The end-point will receive the id of the offender's profile and then
    return the details of the offender WRT id.
    """
    return offender_controller.get_single_offender(request)


@app.route("/clients/offender/update-offender-info", methods=["POST"])
def update_offender_info():
    """
        End-Point for updating Offender information.
    """
    return offender_controller.update_offender_info(request)


@app.route("/clients/offenders/active", methods=["GET"])
def get_active_offenders():
    """
    Function will return offenders with active status
    """
    return offender_controller.get_active_offenders(request)


@app.route("/clients/offenders/pending", methods=["GET"])
def get_pending_offenders():
    """
    Function will return offenders with active status
    """
    return offender_controller.get_pending_offenders(request)


@app.route("/offender/get-current-location", methods=["GET"])
def get_offender_location():
    """
    This function will return the current location of the offender.
    """
    return offender_controller.get_offender_location(request)


@app.route("/offenders/search", methods=["GET"])
def get_offenders_by_query():
    """
    Function to search offender based on offender details like first name, last name etc.
    """
    return offender_controller.get_offenders_by_query(request)


if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0", port=5000, threaded=True)
