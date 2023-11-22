import jwt
from datetime import datetime, timedelta


def getToken(email, password, key):
    """
    It will generate and return JWT Token.
    :param email:
    :param password:
    :param key:
    :return:
    """
    try:
        exp_time = int((datetime.now() + timedelta(hours=(24*15))).timestamp())
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



