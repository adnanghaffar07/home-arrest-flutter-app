import datetime


# from marshmallow import Schema, fields


class Offender:
    """
        Offender client model.
    """
    clientType: str
    firstName: str
    middleName: str
    lastName: str
    maidenName: str
    dateOfBirth: str
    ssn: str
    phoneNumber: str
    emailAddress: str
    sentenceStartDate: str
    sentenceEndDate: str
    checkIn: str
    monitorLevel: str
    location = {
        "lat": 31.47601069443745,
        "lng": 74.30950803039627
    }
    agentAssigned: str
    dateOfEntry: str
    uniqueId: str
    active: bool
    addedBy: str
    profilePic: str
    scoreCard = {
        "monitoringPeriod": "20-03-2023",
        "totalCheckins": 0,
        "outstanding": 0,
        "late": 0,
        "voluntaryCheckins": 0
    }
    recentAlerts = {
        "monitoringPeriod": "20-03-2023",
        "totalCheckins": 0,
        "outstanding": 0,
        "late": 0,
        "voluntaryCheckins": 0
    }
    courtAppearances = {
        "monitoringPeriod": "20-03-2023",
        "totalCheckins": 0,
        "outstanding": 0,
        "late": 0,
        "voluntaryCheckins": 0
    }
    checkInDetails = [{
        "requestTime": "29-11-23",
        "checkedInTime": "29-11-23",
        "description": "Voluntary Check-in Request"
    }]
    pinNumber = ""
    braceletName = ""
    braceletVersion = ""
    breathalyzer = []
    allDocumentPresent = False
    absconded = False
    appearanceDate = ""
    appearanceTime = ""
    specialInstructions = ""
    monitoringInformation = ""
    monitoringFrequency = ""
    monitorTime = ""
    photoCheckIn = False
    videoCheckIn = False
    sobrietyCheckIn = False
    requiredTimesCheckIn = False
    mainScheduleOnly = False
    contactDetails = {
        "homeAddress": "",
        "homeCity": "",
        "homeCountry": "",
        "homeProvince": "",
        "homePostalCode": "4242",
        "homeLat": 31.342,
        "homeLng": 71.324,
        "homeRadius": 0,
        "homePhoneNumber": ""
    }
    workDetails = {
        "workAddress": "",
        "workCity": "",
        "workCountry": "",
        "workProvince": "",
        "workPostalCode": "",
        "workLat": 31.342,
        "workLng": 71.342,
        "workRadius": 0,
        "workPhoneNumber": "",
        "employerName": ""
    }
    personalDetails = {
        "materialStatus": "",
        "rentOrOwn": "",
        "howLongInMonths": "",
        "howLongInYears": "",
        "other": "",
        "sourceOfIncome": "",
        "driverLicenceNo": "",
        "driverLicenceState": "",
        "age": "",
        "usStatus": "",
        "usCitizen": "",
        "alsoKnownAs": "",
        "race": "",
        "sex": "",
        "height": "",
        "weight": "",
        "eye": ""
    }
    billingDetails = {
        "monitoringFee": 0.0,
        "signUpFee": 0.0,
        "paymentAmount": 0.0,
        "paymentFrequency": "",
        "thirdPartyPay": False,
        "thirdParty": ""
    }
    guarantors = ""


class User:
    """
    User Model
    """
    uniqueId: str
    firstName: str
    lastName: str
    userName: str
    location = {
        "lat": 0.0,
        "lng": 0.0
    }
    email: str
    gender: str
    phoneNumber: str
    password: str
    profilePic: str
    role: int  # 1- Super User     2- Super Admin      3- Admin
    roleName: str
    dateOfRegistration = datetime.datetime.now()
    clientsAssigned: list

# class Login(Schema):
#     email = fields.Str(required=True)
#     password = fields.Str(required=True)
