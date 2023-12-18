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
    monitorLevel: int  # 1- Low    2- Medium   3- High
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
    notificationAlerts = {
        "alertId": "ds9fuh948ywjdh",
        "description": "",
        "uniqueId": "any@sam_com",  # Unique ID of the user
        "timestamp": "timestamp",
        "readStatus": False
    }
    courtAppearances = {
        "monitoringPeriod": "20-03-2023",
        "totalCheckins": 0,
        "outstanding": 0,
        "late": 0,
        "voluntaryCheckins": 0
    }
    checkInRequest = [{
        "requestType": "pin",
        "checkinPin": "324324",
        "requestTime": "",
        "deadline": "",
        "status": True,
        "offenderId": "adnan@codeautomation_ai"
    }]
    pinNumber = ""
    signature = ""
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
    guarantors = ""
