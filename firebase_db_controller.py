import datetime
import uuid

import pyrebase
from credentials import firebase_config
import features
import firebase_admin
from firebase_admin import credentials, auth

# firebase_admin library
# ************************************************************************************************************
cred = credentials.Certificate("cred.json")  # loading JSON credentials file.
firebase_admin.initialize_app(cred)  # initialization firebase application.
# ************************************************************************************************************

# pyrebase library.
# ************************************************************************************************************
firebase = pyrebase.initialize_app(firebase_config)
database = firebase.database()
auth2 = firebase.auth()
storage = firebase.storage()


# ************************************************************************************************************


def register_user(payload):
    """
    Function will receive user details and then add in the db.
    First user will be created and authenticated and then will be saved in the database.
    """
    email = payload.get("email", "")
    password = payload.get("password", "")
    try:
        auth2.create_user_with_email_and_password(email, password)
        print(">>> REGISTRATION SUCCESSFUL")
        # Get name for document
        unique_id = features.get_unique_name_for_document(email)
        payload["uniqueId"] = unique_id
        del payload["password"]
        # function to add user in the db.
        if add_user_in_database(payload):
            print("USER ADDED SUCCESSFULLY...")
            return True, 200
        else:
            return False, 401
    except Exception as e:
        print(f"ERROR >>> {e}")
    return False, 403


def add_user_in_database(payload):
    """
    This function will add details in database
    """
    try:
        database.child("Users").child(payload.get("uniqueId")).set(payload)
        return True
    except Exception as e:
        print(f"ERROR >>> {e}")
    return False


def login_user(payload):
    email = payload.get("email")
    password = payload.get("password")
    try:
        auth2.sign_in_with_email_and_password(email, password)
        unique_id = features.get_unique_name_for_document(email)
        details = dict(database.child("Users").child(unique_id).get().val())
        if not details.get("clientsAssigned"):
            details["clientsAssigned"] = []
        return True, details
    except Exception as e:
        print(f"ERROR >>> {e}")
    return False, None


def add_offender_client(client):
    """
    function to create new offender.
    """
    try:
        unique_id = client.get("uniqueId", "")
        if if_entry_exists("Offenders", unique_id):
            return 403
        details = dict(database.child("Offenders").child(unique_id).set(client))
        print(details)
        # function for updating user details.
        agent_id = client.get("agentAssigned", "")
        add_offender_id_in_user_details(features.get_unique_name_for_document(agent_id), unique_id)
        print(details)
        return 201
    except Exception as e:
        print("ADD OFFENDER ERROR >>> ", e)
    return 500


def add_offender_id_in_user_details(agent_id, offender_id):
    try:
        client_list = []
        offenders_list = database.child("Users").child(agent_id).get().val()
        if offenders_list:
            offenders_list = dict(offenders_list)
            print(offenders_list)
            if not offenders_list.get("clientsAssigned"):
                if offender_id not in client_list:
                    client_list.append(offender_id)
                    database.child("Users").child(agent_id).update({"clientsAssigned": client_list})
                return True
            elif offenders_list.get("clientsAssigned"):
                client_list = list(offenders_list.get("clientsAssigned"))
                print(client_list)
                if offender_id not in client_list:
                    client_list.append(offender_id)
                    database.child("Users").child(agent_id).update({"clientsAssigned": client_list})
                return True
    except Exception as e:
        print(f"ERROR ADD OFFENDER ID IN USER >>>> {e}")
    return False


def if_entry_exists(collection, unique_id):
    """
    Function to check if the entry exists in the database with provided unique name.
    """
    try:
        check = database.child(collection).child(unique_id).get().val()
        if check:
            return True
    except Exception as e:
        print(f"IF EXIST ERROR >>> {e}")
    return False


def get_offenders_details_list(user_id):
    """
    Function will return list of offenders. The list contains objects which contains the complete
    information of offender.
    """
    #   Algorithm to get data according to old front-end concept where clients were being assigned to agents
    #   manually.
    # try:
    #     users = database.child("Users").get().val()
    #     if users:
    #         users = dict(users)
    #         resp_users = []
    #         for key, value in users.items():
    #             assigned_clients = users.get(key).get("clientsAssigned")
    #             client_list = []
    #             if assigned_clients:
    #                 for client in assigned_clients:
    #                     client_details = database.child("Offenders").child(client).get().val()
    #                     if client_details:
    #                         client_list.append(dict(client_details))
    #             else:
    #                 users[key]["clientsAssigned"] = []
    #             users[key]["clientAssignedDetails"] = client_list
    #             resp_users.append(users[key])
    #         return resp_users
    # except Exception as e:
    #     print(e)
    #     return None
    try:
        details = database.child("Offenders").order_by_child("agentAssigned").equal_to(user_id).get().val()
        if details:
            payload = list(dict(details).values())
            return payload
        # payload = []
        # if details:
        #     details = dict(details)
        #     for key, value in details.items():
        #         user_id = details.get(key).get("agentAssigned", "")
        #         # function to get agent details.
        #         details[key]["agentDetails"] = agents[features.get_unique_name_for_document(user_id)]
        #         payload.append(details[key])
        #     return payload
    except Exception as e:
        print(e)
    return []


def get_offender_details(client_id):
    """
    This function will take client_id as parameter and returns the
    offender information with the provided client id
    """
    try:
        client = database.child("Offenders").child(client_id).get().val()
        if client:
            client = dict(client)
            client["agentDetails"] = get_profile_details(
                features.get_unique_name_for_document(client.get("agentAssigned", "")))
            return dict(client)
    except Exception as e:
        print(f"ERROR >>> {e}")
    return None


def update_user_profile_details(payload, email):
    """
    This function will take two parameters i.e., payload and email address of the user.
    This function will update user profile details.
    """
    try:
        unique_id = features.get_unique_name_for_document(email)
        user = database.child("Users").child(unique_id).update(payload)
        print(user)
        return payload
    except Exception as e:
        print(f"UPDATE DETAILS ERROR >>> {e}")
    return None


def get_profile_details(email):
    """
    This function will take email address as parameter, then after convert it into unique id
    by which user is stored in the database and return the details of the user with provided
    unique id.
    """
    try:
        unique_id = features.get_unique_name_for_document(email)
        user = database.child("Users").child(unique_id).get().val()
        if user:
            return dict(user)
    except Exception as e:
        print(f"PROFILE DETAILS ERROR >>> {e}")
    return None


def update_offender_client_info(payload):
    """
    This function will take offender's updated details and update it in the database.
    """
    try:
        unique_id = payload.get("uniqueId", "")
        print(unique_id)
        if if_entry_exists("Offenders", unique_id):
            user = database.child("Offenders").child(unique_id).update(payload)
            # print(user)
            return user
    except Exception as e:
        print(f"ERROR >>> {e}")
    return None


def get_admin_by_role_id(role_id):
    """
    This function will return the users registered in the database WRT role id.
    1- Super User
    2- Super Admin
    3- Admin
    """
    try:
        users = database.child("Users").order_by_child("role").equal_to(role_id).get().val()
        if users:
            # payload = []
            users = list(dict(users).values())
            # for key, value in users.items():
            #     if users[key]["role"] == role_id:
            #         del users[key]["password"]
            #         payload.append(users[key])
            return users
    except Exception as e:
        print(f"ERROR >>> {e}")
    return []


def update_user_password(email, new_password):
    """
    In this specific function, firebase_admin library is used for updating password.
    Password update feature with pyrebase library is a bit complex so firebase_admin is
    being used to update the password.
    """
    user = auth.get_user_by_email(email)
    uid = user.uid
    try:
        # Update the user's password using the Firebase Admin SDK
        auth.update_user(uid, password=new_password)
        print(f"Password changed successfully for user {uid}.")
        user = database.child("Users").child(features.get_unique_name_for_document(email)).get().val()
        if user:
            return dict(user)
    except Exception as e:
        print(f"Error changing password: {e}")
    return {}


def update_admin_role(admin_id, role_status):
    """
    The function will take admin id and role status i.e., True or False for user activeness.
    This function will update Offender active and inactive with the help of boolean
    value.
    """
    if role_status == 1:
        role_name = "super user"
    elif role_status == 2:
        role_name = "super admin"
    if role_status == 3:
        role_name = "admin"
    try:
        user = database.child("Users").child(admin_id).update({"role": role_status, "roleName": role_name})
        if user:
            return True
    except Exception as e:
        print(f"ERROR >>> {e}")
    return False


def get_offenders_by_status(status):
    """
    The function will return offenders which are active i.e., contains active status True.
    """
    try:
        clients = database.child("Offenders").order_by_child("active").equal_to(status).get().val()
        if clients:
            # offenders = []
            clients = list(dict(clients).values())
            # for key, value in clients.items():
            #     if clients[key].get("active") == status:
            #         print(f"ACTIVE CLIENT >>> {clients[key]['emailAddress']}")
            #         offenders.append(clients[key])
            return clients
    except Exception as e:
        print(f"ERROR ACTIVE OFFENDERS >>> {e}")
    return []


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


def update_user_current_location(payload, user_id):
    try:
        user = database.child("Users").child(user_id).update(payload)
        if user:
            return 200
        else:
            return 404
    except Exception as e:
        print(f"ERROR UPDATING CURRENT LOCATION >>> {e}")
    return 500


def get_offender_current_location(offender_id):
    try:
        offender = database.child("Offenders").child(offender_id).get().val()
        if offender:
            offender = dict(offender)
            location = offender.get("location")
            if location:
                return location, 200
            else:
                return "NA", 200
    except Exception as e:
        print(f"ERROR FOR GETTING OFFENDER CURRENT LOCATION >>> {e}")
    return None, 404


def user_search_by_query(query):
    """
    Function will receive searched query as parameter and search for user according to
    the provided query.
    """
    results = []
    query = str(query).lower()
    try:
        payload = database.child("Users").get().val()
        if payload:
            payload = list(dict(payload).values())
            for user in payload:
                if query in str(user.get("firstName", "")).lower():
                    results.append(user)
                if query in str(user.get("lastName", "")).lower():
                    results.append(user)
                if query in user.get("email", ""):
                    results.append(user)
                if query in user.get("phoneNumber", ""):
                    results.append(user)
                if query in str(user.get("userName")).lower():
                    results.append(user)
            results = features.filter_duplicates_from_dict(results, "email")
    except Exception as e:
        print(f"ERROR SEARCH USER >>> {e}")
    return results


def offender_search_by_query(query, agent_id):
    results = []
    query = str(query).lower()
    try:
        payload = database.child("Offenders").order_by_child("agentAssigned").equal_to(agent_id).get().val()
        if payload:
            payload = list(dict(payload).values())
            for user in payload:
                if query in user.get("firstName").lower():
                    results.append(user)
                if query in user.get("lastName").lower():
                    results.append(user)
                if query in user.get("emailAddress"):
                    results.append(user)
                if query in user.get("phoneNumber"):
                    results.append(user)
                if query in user.get("middleName").lower():
                    results.append(user)
                if query in user.get("maidenName").lower():
                    results.append(user)
                if query in user.get("ssn"):
                    results.append(user)
            results = features.filter_duplicates_from_dict(results, "emailAddress")
    except Exception as e:
        print(f"ERROR SEARCH USER >>> {e}")
    return results


def add_request_checkin(payload, agent_id, offender_id):
    try:
        payload["requestedById"] = agent_id
        payload["requestId"] = uuid.uuid4().hex
        payload["requestTime"] = str(datetime.datetime.now())
        payload["status"] = False
        database.child("Offenders").child(offender_id).child("checkInRequest").push(payload)
        return 200, payload
        # if offender_data:
        #     offender_data = list(offender_data)
        #     print(offender_data)
        #     payload["requestedById"] = agent_id
        #     payload["requestId"] = uuid.uuid4().hex
        #     payload["requestTime"] = str(datetime.datetime.now())
        #     payload["status"] = False
        #     offender_data.append(payload)
        #     database.child("Offenders").child(offender_id).update({"checkInRequest": offender_data})
        # else:
        #     payload["requestedById"] = agent_id
        #     payload["requestTime"] = str(datetime.datetime.now())
        #     payload["requestId"] = uuid.uuid4().hex
        #     payload["status"] = False
        #     request_list = [payload]
        #     database.child("Offenders").child(offender_id).update({"checkInRequest": request_list})
        #     return 200, payload
    except Exception as e:
        print(f"REQUEST CHECKIN ERROR >>> {e}")
    return 500, None


def set_alerts_in_db(payload, user_id):
    try:
        response = database.child("Alerts").child(user_id).push(payload)
        if response:
            return True
    except Exception as e:
        print(f"ERROR SETTING ALERTS >>> {e}")
    return False


def get_alerts_from_db(offender_list):
    alerts = []
    try:
        response = database.child("Alerts").get().val()
        offenders_details = database.child("Offenders").get().val()
        if offenders_details:
            offenders_details = dict(offenders_details)
        if response:
            response = dict(response)
            print(response)
            for offender in offender_list:
                if response.get(offender):
                    offender_response = response.get(offender, {})
                    payload = {
                        "fullName": f"{offenders_details.get(offender).get('firstName')} {offenders_details.get(offender).get('lastName')}",
                        "uniqueId": f"{offenders_details.get(offender).get('uniqueId')}",
                        "profilePic": f"{offenders_details.get(offender).get('profilePic')}",
                        "alerts": list(offender_response.values())[::-1]
                    }
                    alerts.append(payload)
    except Exception as e:
        print(f"ERROR GETTING ALERTS >>> {e}")
    return alerts


def change_alert_read_status(alert_id, unique_id):
    try:
        resp = database.child("Alerts").child(unique_id).get().val()
        if resp:
            resp = dict(resp)
            print(resp)
            for key, alert in resp.items():
                if resp[key]["alertId"] == alert_id:
                    resp[key]["readStatus"] = True
                    database.child("Alerts").child(unique_id).update(resp)
            return True
    except Exception as e:
        print(f"ERROR CHANGING ALERT READ STATUS >>> {e}")
    return False
