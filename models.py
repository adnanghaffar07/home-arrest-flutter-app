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
    offenceDetails = {
        "priorArrest": "",
        "priorArrestJurisdiction": "",
        "cause1": "",
        "cause2": "",
        "judgeName": "",
        "courtName": "",
        "caseNo": "",
        "offence": "",
        "appearanceDate": "",
        "appearanceTime": "",
        "specialInstruction": "",
        "clientNotification": {
            "gpsLocationUpdate": False,
            "monitoringAlerts": {
                "alertEmails": "",
                "firstWarning": 5,
                "secondWarning": 15,
                "weeklyReports": {
                    "reportEmails": "",
                    "weeklyReport": ""
                }

            }
        }
    }
    mainScheduleDetails = {
        "1-AM": False,
        "2-AM": False,
        "3-AM": False,
        "4-AM": False,
        "5-AM": False,
        "6-AM": False,
        "7-AM": False,
        "8-AM": False,
        "9-AM": False,
        "10-AM": False,
        "11-AM": False,
        "12-PM": False,
        "1-PM": False,
        "2-PM": False,
        "3-PM": False,
        "4-PM": False,
        "5-PM": False,
        "6-PM": False,
        "7-PM": False,
        "8-PM": False,
        "9-PM": False,
        "10-PM": False,
        "11-PM": False,
        "midnight": False
    }
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
        "workState": "",
        "workProvince": "",
        "workPostalCode": "",
        "workLat": 31.342,
        "workLng": 71.342,
        "workRadius": 0,
        "workPhoneNumber": "",
        "employerName": ""
    },
    paymentHistory = []
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
        "eye": "",
        "hair": "",
        "build": "",
        "leftOrRightHanded": "",
        "tattoos": "",
        "prevMarriedName": "",
    }
    billingDetails = {
        "monitoringFee": 0.0,
        "signUpFee": 0.0,
        "adminFee": 0.0,
        "paymentAmount": 0.0,
        "paymentFrequency": "",
        "thirdPartyPay": False,
        "thirdParty": ""
    }
    guarantors = ""
