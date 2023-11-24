import datetime


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
    location = {}
    agentAssigned: str
    dateOfEntry: str
    uniqueId: str
    active: bool
    addedBy: str
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


class User:
    """
    User Model
    """
    uniqueId: str
    firstName: str
    lastName: str
    userName: str
    location = {}
    email: str
    gender: str
    phoneNumber: str
    password: str
    role: int           # 1- Super User     2- Super Admin      3- Admin
    dateOfRegistration = datetime.datetime.now()
    clientsAssigned: list
