import datetime


class Offender:
    """
        Offender client model.
    """
    _id: str
    clientType: str
    firstName: str
    middleName: str
    lastName: str
    maidenName: str
    dateOfBirth: datetime.datetime
    ssn: str
    phoneNumber: str
    emailAddress: str
    sentenceStartDate: datetime.datetime
    sentenceEndDate: datetime.datetime
    checkIn: str
    monitorLevel: str
    location = {}
    agentAssigned: str
    dateOfEntry: str
    addedBy: str


class User:
    _id: str
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