import pyrebase
from credentials import firebase_config
import features

firebase = pyrebase.initialize_app(firebase_config)
database = firebase.database()
auth = firebase.auth()


def register_user(payload):
    """
    Function will receive user details and then add in the db.
    First user will be created and authenticated and then will be saved in the database.
    """
    email = payload.get("email", "")
    password = payload.get("password", "")
    try:
        user = auth.create_user_with_email_and_password(email, password)
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
        user = auth.sign_in_with_email_and_password(email, password)
        unique_id = features.get_unique_name_for_document(email)
        details = dict(database.child("Users").child(unique_id).get().val())
        return True, details
    except Exception as e:
        print(f"ERROR >>> {e}")
    return False, None


def add_offender_client(client):
    try:
        unique_id = client.get("_id", "")
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
                payload.append(details[key])
            return payload
    except Exception as e:
        print(e)


def get_offender_details(client_id):
    try:
        client = database.child("Offenders").child(client_id).get().val()
        if client:
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

