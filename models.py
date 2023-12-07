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
        "requestID": "3435535",
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
    braceletConnection = False
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
    checkInRequest = {
        "requestId": "489qy2j98q4",
        "requestType": "image",  # 1- image  2- video    3- pin
        "requestTime": "",  # time of request sent
        "deadline": "",  # time limit for checkin
        "status": False,
        "requestedById": "something@anything_com"  # unique Id
    }
    guarantors = ""
