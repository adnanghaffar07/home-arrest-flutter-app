import jwt
from datetime import datetime, timedelta
import firebase_db_controller as db

from flask import request

secret_key = "0F53127e42354ze38D4024a9e2789a24"


def getToken(email, password, key):
    """
    It will generate and return JWT Token.
    :param email:
    :param password:
    :param key:
    :return:
    """
    try:
        exp_time = int((datetime.now() + timedelta(hours=(24 * 15))).timestamp())
        token = jwt.encode({
            "email": email,
            "password": password,
            'exp': exp_time,
        }, key, algorithm="HS256")
        print(token)
        return token
    except Exception as e:
        print(f"ERROR >>>> {e}")
        return None


def verify(token, key):
    """
    token verification. valid or expired. if valid then further fetch data from the database.
    :param token:
    :param key:
    :return:
    """
    try:
        signature = jwt.decode(token, key, algorithms=["HS256"])
        print({"signature": signature})
        return signature
    except jwt.exceptions.InvalidTokenError as e:
        print("Error While Decoding Token>>>", e)
        return None


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
            payload = verify(token, secret_key)  # Function to verify token.
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
