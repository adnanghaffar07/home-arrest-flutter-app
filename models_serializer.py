from marshmallow import Schema, fields


class OffenderSerializer(Schema):
    """
        Offender client model.
    """
    clientType = fields.Str(required=False)
    firstName = fields.Str(required=False)
    middleName = fields.Str(required=False)
    lastName = fields.Str(required=False)
    maidenName = fields.Str(required=False)
    dateOfBirth = fields.Str(required=False)
    ssn = fields.Str(required=False)
    phoneNumber = fields.Str(required=False)
    emailAddress = fields.Email(required=False)
    sentenceStartDate = fields.Str(required=False)
    sentenceEndDate = fields.Str(required=False)
    checkIn = fields.Str(required=False)
    monitorLevel = fields.Int(required=False)       # 1- Low    2- Medium   3- High
    location = fields.Dict(required=False)
    agentAssigned = fields.Str(required=False)
    dateOfEntry = fields.Str(required=False)
    uniqueId = fields.Str(required=False)
    active = fields.Str(required=False)
    addedBy = fields.Str(required=False)
    profilePic = fields.Str(required=False)
    scoreCard = fields.Dict(required=False)
    recentAlerts = fields.Dict(required=False)
    courtAppearances = fields.Dict(required=False)
    checkInRequest = fields.List(fields.Dict(), required=False)
    pinNumber = fields.Str(required=False)
    braceletName = fields.Str(required=False)
    braceletVersion = fields.Str(required=False)
    breathalyzer = fields.List(fields.Str(), required=False)
    allDocumentPresent = fields.Bool(required=False)
    absconded = fields.Bool(required=False)
    appearanceDate = fields.Str(required=False)
    appearanceTime = fields.Str(required=False)
    specialInstructions = fields.Str(required=False)
    monitoringInformation = fields.Str(required=False)
    monitoringFrequency = fields.Str(required=False)
    monitorTime = fields.Str(required=False)
    signature = fields.Str(required=False)
    photoCheckIn = fields.Bool(required=False)
    videoCheckIn = fields.Bool(required=False)
    sobrietyCheckIn = fields.Bool(required=False)
    requiredTimesCheckIn = fields.Bool(required=False)
    mainScheduleOnly = fields.Bool(required=False)
    braceletConnection = fields.Bool(required=False)
    contactDetails = fields.Dict(required=False)
    workDetails = fields.Dict(required=False)
    personalDetails = fields.Dict(required=False)
    billingDetails = fields.Dict(required=False)
    guarantors = fields.Str(required=False)


class Login(Schema):
    email = fields.Email(required=True)
    password = fields.Str(required=True)


class UserSerializer(Schema):
    """
    User Model
    """
    uniqueId = fields.Str(required=False)
    firstName = fields.Str(required=False)
    lastName = fields.Str(required=False)
    userName = fields.Str(required=False)
    location = fields.Dict(required=False)
    email = fields.Email(required=False)
    gender = fields.Str(required=False)
    phoneNumber = fields.Str(required=False)
    password = fields.Str(required=False)
    profilePic = fields.Str(required=False)
    role = fields.Int(required=False)  # 1- Super User     2- Super Admin      3- Admin
    roleName = fields.Str(required=False)
    dateOfRegistration = fields.Str(required=False)
    clientsAssigned = fields.Str(required=False)
    address1 = fields.Str(required=False)
    address2 = fields.Str(required=False)
    country = fields.Str(required=False)
    state = fields.Str(required=False)
    dailyReport = fields.Bool(required=False)
    notifications = fields.Dict(required=False)
