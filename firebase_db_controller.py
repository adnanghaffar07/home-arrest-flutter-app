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


# ************************************************************************************************************


def register_user(payload):
    """
    Function will receive user details and then add in the db.
    First user will be created and authenticated and then will be saved in the database.
    """
    email = payload.get("email", "")
    password = payload.get("password", "")
    try:
        user = auth2.create_user_with_email_and_password(email, password)
        print(">>> REGISTRATION SUCCESSFUL")
        # Get name for document
        unique_id = features.get_unique_name_for_document(email)
        payload["uniqueId"] = unique_id
        # function to add user in the db.
        if add_user_in_database(payload):
            print("USER ADDED SUCCESSFULLY...")
            return True, 200
        else:
            return False, 401
    except Exception as e:
        print(f"ERROR >>> {e}")
    return False, 400


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
        return True, details
    except Exception as e:
        print(f"ERROR >>> {e}")
    return False, None


def add_offender_client(client):
    try:
        unique_id = client.get("uniqueId", "")
        if if_entry_exists("Offenders", unique_id):
            return False
        details = dict(database.child("Offenders").child(unique_id).set(client))
        print(details)
        return True
    except Exception as e:
        print("ADD OFFENDER ERROR >>> ", e)
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


def get_offenders_details_list():
    try:
        details = database.child("Offenders").get().val()
        details = dict(details)
        payload = []
        if details:
            for key, value in details.items():
                user_id = details.get(key).get("agentAssigned")
                # function to get agent details.
                details[key]["agentDetails"] = get_profile_details(features.get_unique_name_for_document(user_id))
                del details[key]["agentDetails"]["password"]  # for privacy deleting password field from payload.
                payload.append(details[key])
            return payload
    except Exception as e:
        print(e)


def get_offender_details(client_id):
    try:
        client = database.child("Offenders").child(client_id).get().val()
        if client:
            client = dict(client)
            client["agentDetails"] = get_profile_details(
                features.get_unique_name_for_document(client.get("agentAssigned", "")))
            del client["agentDetails"]["password"]
            return dict(client)
    except Exception as e:
        print(f"ERROR >>> {e}")
    return None


def update_user_profile_details(payload, email):
    try:
        unique_id = features.get_unique_name_for_document(email)
        user = database.child("Users").child(unique_id).update(payload)
        print(user)
        return payload
    except Exception as e:
        print(f"UPDATE DETAILS ERROR >>> {e}")
    return None


def get_profile_details(email):
    try:
        unique_id = features.get_unique_name_for_document(email)
        user = database.child("Users").child(unique_id).get().val()
        if user:
            return dict(user)
    except Exception as e:
        print(f"PROFILE DETAILS ERROR >>> {e}")
    return None


def update_offender_client_info(payload):
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
    try:
        users = database.child("Users").get().val()
        if users:
            payload = []
            users = dict(users)
            for key, value in users.items():
                if users[key]["role"] == role_id:
                    del users[key]["password"]
                    payload.append(users[key])
            return payload
    except Exception as e:
        print(f"ERROR >>> {e}")
    return None


def update_user_password(email, new_password):
    user = auth.get_user_by_email(email)
    uid = user.uid
    try:
        # Update the user's password using the Firebase Admin SDK
        auth.update_user(uid, password=new_password)
        print(f"Password changed successfully for user {uid}.")
        user = database.child("Users").child(features.get_unique_name_for_document(email)).update(
            {"password": new_password})
        return dict(user)
    except Exception as e:
        print(f"Error changing password: {e}")
        return False


def update_admin_role(admin_id, role_status):
    try:
        user = database.child("Users").child(admin_id).update({"role": role_status})
        if user:
            return True
        else:
            return False
    except Exception as e:
        print(f"ERROR >>> {e}")
    return False


def get_active_offenders():
    try:
        clients = database.child("Offenders").get().val()
        if clients:
            offenders = []
            clients = dict(clients)
            for key, value in clients.items():
                if clients[key].get("active"):
                    print(f"ACTIVE CLIENT >>> {clients[key]['emailAddress']}")
                    offenders.append(clients[key])
            return offenders
    except Exception as e:
        print(f"ERROR ACTIVE OFFENDERS >>> {e}")
    return None
