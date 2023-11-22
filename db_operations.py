import datetime
import random
import uuid

from humanize import naturaltime
import pymongo
from credentials import connection_string
import features

connection = pymongo.MongoClient(connection_string)  # connection object.


def db_connection(database, collection):
    """
    Function returns the collection object.
    :param database:
    :param collection:
    :return:
    """
    global connection
    db = connection[database]  # database selection
    col = db[collection]  # collection selection
    return col


def register_user(payload):
    """
    Function will receive payload of the user containing details of the user and save it in the database.
    :param payload:
    :return:
    """
    collection = db_connection(database="home_arrest", collection="user")
    check_existance = collection.find_one({"phoneNumber": payload["phoneNumber"]})
    if check_existance:
        return False
    payload["_id"] = payload["email"]
    payload["dateOfRegistration"] = datetime.datetime.now()
    try:
        collection.insert_one(payload)
        return True
    except Exception as e:
        print(f"[]-- {e}")
    return False


def login_user(payload):
    """
    This function is for login purpose. Parameter contains a dictionary which include email address
    and password for login verification.
    :param payload:
    :return:
    """
    collection = db_connection(database="home_arrest", collection="user")
    user = collection.find_one({"$and": [{"_id": payload["email"]}, {"password": payload["password"]}]},
                               {"password": 0})
    if user:
        # print(user)
        del user["_id"]
        return True, user
    else:
        print("not found...")
        return False, None


def get_user_for_security(email):
    """
    Function to check if user exists with provided email. If yes then it will generate a security code and save it in
    the database
    :param email:
    :return:
    """
    collection = db_connection(database="home_arrest", collection="user")
    user = collection.find_one({"_id": email})
    if user:
        security_code = random.randint(100000, 999999)
        print(security_code)
        collection.update_one({"_id": email}, {"$set": {"securityCode": security_code}})
        user["securityCode"] = security_code
        # print(user)
    return user


def verify_security_code(email, security_code):
    """
    Function contains two parameters i.e., email and security code. This function verifies the user sent code with the
    security code saved in the database and respond accordingly.
    :param email:
    :param security_code:
    :return:
    """
    collection = db_connection("home_arrest", "user")
    user = collection.find_one({"$and": [{"_id": email}, {"securityCode": security_code}]})
    print(user)
    # To remove securityCode from collection, the below function can be used
    if user:
        collection.update_one({"_id": email}, {"$unset": {"securityCode": ""}})
    return user


def update_new_password(payload):
    """
    After security code verification, user can update or reset his/her previous password which will then update in
    the database.
    :param payload:
    :return:
    """
    collection = db_connection("home_arrest", "user")
    email = payload["email"]
    new_password = payload["password"]
    response = collection.find_one_and_update({"_id": email}, {"$set": {"password": new_password}})
    if response:
        # response["password"] = new_password
        del response["_id"]  # This _id is for MongoDB. No use for front-end side.
    return response


def required_field(database, collection, req_id, field):
    """
    If the field exist, the function will return the value of the required field, else it will return None.
    """
    collection = db_connection(database, collection)
    try:
        response = collection.find_one({"_id": req_id}, {field: 1})
        return response.get(field)
    except Exception as e:
        print("ERROR >>> ", e)
        return None


def get_required_field(payload):
    """
    Function will take dictionary containing required field and id of the collection's document of MongoDB.
    """
    field = payload.get("fieldRequired")
    if field == "password":
        return None
    req_value = required_field("home_arrest", "user", payload.get("id"), field)
    return req_value


def add_offender_client(payload):
    """
    Function will add offender in the database.
    """
    collection = db_connection("home_arrest", "offender_clients")
    try:
        collection.insert_one(payload)
        return True
    except Exception as e:
        print("ERROR >>> ", e)
    return False


def get_offenders_details_list():
    collection = db_connection("home_arrest", "offender_clients")
    try:
        payload = collection.find()
        clients = []
        for item in payload:
            clients.append(item)
        return clients
    except Exception as e:
        print("ERROR >>> ", e)
    return None


def get_offender_details(client_id):
    collection = db_connection("home_arrest", "offender_clients")
    try:
        payload = collection.find_one({"_id": client_id})
        return payload
    except Exception as e:
        print("ERROR >>> ", e)
    return None


def update_user_profile_details(payload, email):
    collection = db_connection("home_arrest", "user")
    try:
        response = collection.find_one_and_update({"_id": email}, {"$set": payload})
        return response
    except Exception as e:
        print(f"ERROR >>> {e}")
    return None


def update_user_password(email, password):
    collection = db_connection("home_arrest", "user")
    try:
        resp = collection.find_one_and_update({"_id": email}, {"$set": {
            "password": password
        }})
        resp["password"] = password
        return resp
    except Exception as e:
        print("ERROR")
    return None
