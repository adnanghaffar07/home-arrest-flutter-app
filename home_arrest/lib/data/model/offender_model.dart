import 'location_model.dart';
import 'notification_model.dart';

class OffendorModel {
  bool? absconded;
  String? active;
  String? addedBy;
  String? agentAssigned;
  AgentDetails? agentDetails;
  bool? allDocumentPresent;
  String? appearanceDate;
  String? appearanceTime;
  BillingDetails? billingDetails;
  bool? braceletConnection;
  List<dynamic>? braceletHistory;
  String? braceletName;
  String? braceletVersion;
  String? checkIn;
  List<CheckInRequest>? checkInRequest;
  String? clientType;
  ContactDetails? contactDetails;
  CourtAppearances? courtAppearances;
  String? dateOfBirth;
  DateTime? dateOfEntry;
  String? emailAddress;
  String? firstName;
  String? guarantors;
  String? lastName;
  Location? location;
  String? maidenName;
  bool? mainScheduleOnly;
  String? middleName;
  int? monitorLevel;
  String? monitorTime;
  String? monitoringFrequency;
  String? monitoringInformation;
  PersonalDetails? personalDetails;
  String? phoneNumber;
  bool? photoCheckIn;
  String? pinNumber;
  String? profilePic;
  CourtAppearances? recentAlerts;
  bool? requiredTimesCheckIn;
  CourtAppearances? scoreCard;
  String? sentenceEndDate;
  String? sentenceStartDate;
  String? signature;
  bool? sobrietyCheckIn;
  String? specialInstructions;
  String? ssn;
  String? uniqueId;
  bool? videoCheckIn;
  WorkDetails? workDetails;
  bool isSelected = false;

  OffendorModel({
    this.absconded,
    this.active,
    this.addedBy,
    this.agentAssigned,
    this.agentDetails,
    this.allDocumentPresent,
    this.appearanceDate,
    this.appearanceTime,
    this.billingDetails,
    this.braceletConnection,
    this.braceletHistory,
    this.braceletName,
    this.braceletVersion,
    this.checkIn,
    this.checkInRequest,
    this.clientType,
    this.contactDetails,
    this.courtAppearances,
    this.dateOfBirth,
    this.dateOfEntry,
    this.emailAddress,
    this.firstName,
    this.guarantors,
    this.lastName,
    this.location,
    this.maidenName,
    this.mainScheduleOnly,
    this.middleName,
    this.monitorLevel,
    this.monitorTime,
    this.monitoringFrequency,
    this.monitoringInformation,
    this.personalDetails,
    this.phoneNumber,
    this.photoCheckIn,
    this.pinNumber,
    this.profilePic,
    this.recentAlerts,
    this.requiredTimesCheckIn,
    this.scoreCard,
    this.sentenceEndDate,
    this.sentenceStartDate,
    this.signature,
    this.sobrietyCheckIn,
    this.specialInstructions,
    this.ssn,
    this.uniqueId,
    this.videoCheckIn,
    this.workDetails,
    this.isSelected = false,
  });

  factory OffendorModel.fromJson(Map<String, dynamic> json) => OffendorModel(
        absconded: json["absconded"],
        active: json["active"],
        addedBy: json["addedBy"],
        agentAssigned: json["agentAssigned"],
        agentDetails: json["agentDetails"] == null ? null : AgentDetails.fromJson(json["agentDetails"]),
        allDocumentPresent: json["allDocumentPresent"],
        appearanceDate: json["appearanceDate"],
        appearanceTime: json["appearanceTime"],
        billingDetails: json["billingDetails"] == null ? null : BillingDetails.fromJson(json["billingDetails"]),
        braceletConnection: json["braceletConnection"],
        // braceletHistory: json["braceletHistory"] == null ? [] : List<dynamic>.from(json["braceletHistory"]!.map((x) => x)),
        braceletName: json["braceletName"],
        braceletVersion: json["braceletVersion"],
        checkIn: json["checkIn"],
        // checkInRequest: json["checkInRequest"] == null ? [] : List<CheckInRequest>.from(json["checkInRequest"]!.map((x) => CheckInRequest.fromJson(x))),
        clientType: json["clientType"],
        contactDetails: json["contactDetails"] == null ? null : ContactDetails.fromJson(json["contactDetails"]),
        courtAppearances: json["courtAppearances"] == null ? null : CourtAppearances.fromJson(json["courtAppearances"]),
        dateOfBirth: json["dateOfBirth"],
        dateOfEntry: json["dateOfEntry"] == null ? null : DateTime.parse(json["dateOfEntry"]),
        emailAddress: json["emailAddress"],
        firstName: json["firstName"],
        guarantors: json["guarantors"],
        lastName: json["lastName"],
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        maidenName: json["maidenName"],
        mainScheduleOnly: json["mainScheduleOnly"],
        middleName: json["middleName"],
        monitorLevel: json["monitorLevel"],
        monitorTime: json["monitorTime"],
        monitoringFrequency: json["monitoringFrequency"],
        monitoringInformation: json["monitoringInformation"],
        personalDetails: json["personalDetails"] == null ? null : PersonalDetails.fromJson(json["personalDetails"]),
        phoneNumber: json["phoneNumber"],
        photoCheckIn: json["photoCheckIn"],
        pinNumber: json["pinNumber"],
        profilePic: json["profilePic"],
        recentAlerts: json["recentAlerts"] == null ? null : CourtAppearances.fromJson(json["recentAlerts"]),
        requiredTimesCheckIn: json["requiredTimesCheckIn"],
        scoreCard: json["scoreCard"] == null ? null : CourtAppearances.fromJson(json["scoreCard"]),
        sentenceEndDate: json["sentenceEndDate"],
        sentenceStartDate: json["sentenceStartDate"],
        signature: json["signature"],
        sobrietyCheckIn: json["sobrietyCheckIn"],
        specialInstructions: json["specialInstructions"],
        ssn: json["ssn"],
        uniqueId: json["uniqueId"],
        videoCheckIn: json["videoCheckIn"],
        workDetails: json["workDetails"] == null ? null : WorkDetails.fromJson(json["workDetails"]),
      );

  Map<String, dynamic> toJson() => {
        if (absconded != null) "absconded": absconded,
        if (active != null) "active": active,
        if (addedBy != null) "addedBy": addedBy,
        if (agentAssigned != null) "agentAssigned": agentAssigned,
        if (agentDetails != null) "agentDetails": agentDetails?.toJson(),
        if (allDocumentPresent != null) "allDocumentPresent": allDocumentPresent,
        if (appearanceDate != null) "appearanceDate": appearanceDate,
        if (appearanceTime != null) "appearanceTime": appearanceTime,
        if (billingDetails != null) "billingDetails": billingDetails?.toJson(),
        if (braceletConnection != null) "braceletConnection": braceletConnection,
        if (braceletHistory != null) "braceletHistory": braceletHistory == null ? [] : List<dynamic>.from(braceletHistory!.map((x) => x)),
        if (braceletName != null) "braceletName": braceletName,
        if (braceletVersion != null) "braceletVersion": braceletVersion,
        if (checkIn != null) "checkIn": checkIn,
        if (checkInRequest != null) "checkInRequest": checkInRequest == null ? [] : List<dynamic>.from(checkInRequest!.map((x) => x.toJson())),
        if (clientType != null) "clientType": clientType,
        if (contactDetails != null) "contactDetails": contactDetails?.toJson(),
        if (courtAppearances != null) "courtAppearances": courtAppearances?.toJson(),
        if (dateOfBirth != null) "dateOfBirth": dateOfBirth,
        if (dateOfEntry != null) "dateOfEntry": dateOfEntry?.toIso8601String(),
        if (emailAddress != null) "emailAddress": emailAddress,
        if (firstName != null) "firstName": firstName,
        if (guarantors != null) "guarantors": guarantors,
        if (lastName != null) "lastName": lastName,
        if (location != null) "location": location?.toJson(),
        if (maidenName != null) "maidenName": maidenName,
        if (mainScheduleOnly != null) "mainScheduleOnly": mainScheduleOnly,
        if (middleName != null) "middleName": middleName,
        if (monitorLevel != null) "monitorLevel": monitorLevel,
        if (monitorTime != null) "monitorTime": monitorTime,
        if (monitoringFrequency != null) "monitoringFrequency": monitoringFrequency,
        if (monitoringInformation != null) "monitoringInformation": monitoringInformation,
        if (personalDetails != null) "personalDetails": personalDetails?.toJson(),
        if (phoneNumber != null) "phoneNumber": phoneNumber,
        if (photoCheckIn != null) "photoCheckIn": photoCheckIn,
        if (pinNumber != null) "pinNumber": pinNumber,
        if (profilePic != null) "profilePic": profilePic,
        if (recentAlerts != null) "recentAlerts": recentAlerts?.toJson(),
        if (requiredTimesCheckIn != null) "requiredTimesCheckIn": requiredTimesCheckIn,
        if (scoreCard != null) "scoreCard": scoreCard?.toJson(),
        if (sentenceEndDate != null) "sentenceEndDate": sentenceEndDate,
        if (sentenceStartDate != null) "sentenceStartDate": sentenceStartDate,
        if (signature != null) "signature": signature,
        if (sobrietyCheckIn != null) "sobrietyCheckIn": sobrietyCheckIn,
        if (specialInstructions != null) "specialInstructions": specialInstructions,
        if (ssn != null) "ssn": ssn,
        if (uniqueId != null) "uniqueId": uniqueId,
        if (videoCheckIn != null) "videoCheckIn": videoCheckIn,
        if (workDetails != null) "workDetails": workDetails?.toJson(),
      };
}

class AgentDetails {
  String? address1;
  String? address2;
  List<String>? clientsAssigned;
  String? country;
  bool? dailyReport;
  String? email;
  String? firstName;
  String? gender;
  String? lastName;
  Location? location;
  Notifications? notifications;
  String? phoneNumber;
  String? profilePic;
  int? role;
  String? roleName;
  String? state;
  String? uniqueId;
  String? userName;

  AgentDetails({
    this.address1,
    this.address2,
    this.clientsAssigned,
    this.country,
    this.dailyReport,
    this.email,
    this.firstName,
    this.gender,
    this.lastName,
    this.location,
    this.notifications,
    this.phoneNumber,
    this.profilePic,
    this.role,
    this.roleName,
    this.state,
    this.uniqueId,
    this.userName,
  });

  factory AgentDetails.fromJson(Map<String, dynamic> json) => AgentDetails(
        address1: json["address1"],
        address2: json["address2"],
        clientsAssigned: json["clientsAssigned"] == null ? [] : List<String>.from(json["clientsAssigned"]!.map((x) => x)),
        country: json["country"],
        dailyReport: json["dailyReport"],
        email: json["email"],
        firstName: json["firstName"],
        gender: json["gender"],
        lastName: json["lastName"],
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        notifications: json["notifications"] == null ? null : Notifications.fromJson(json["notifications"]),
        phoneNumber: json["phoneNumber"],
        profilePic: json["profilePic"],
        role: json["role"],
        roleName: json["roleName"],
        state: json["state"],
        uniqueId: json["uniqueId"],
        userName: json["userName"],
      );

  Map<String, dynamic> toJson() => {
        "address1": address1,
        "address2": address2,
        "clientsAssigned": clientsAssigned == null ? [] : List<dynamic>.from(clientsAssigned!.map((x) => x)),
        "country": country,
        "dailyReport": dailyReport,
        "email": email,
        "firstName": firstName,
        "gender": gender,
        "lastName": lastName,
        "location": location?.toJson(),
        "notifications": notifications?.toJson(),
        "phoneNumber": phoneNumber,
        "profilePic": profilePic,
        "role": role,
        "roleName": roleName,
        "state": state,
        "uniqueId": uniqueId,
        "userName": userName,
      };
}

class BillingDetails {
  double? monitoringFee;
  double? paymentAmount;
  String? paymentFrequency;
  double? signUpFee;
  String? thirdParty;
  bool? thirdPartyPay;

  BillingDetails({
    this.monitoringFee,
    this.paymentAmount,
    this.paymentFrequency,
    this.signUpFee,
    this.thirdParty,
    this.thirdPartyPay,
  });

  factory BillingDetails.fromJson(Map<String, dynamic> json) => BillingDetails(
        monitoringFee: json["monitoringFee"].toDouble(),
        paymentAmount: json["paymentAmount"].toDouble(),
        paymentFrequency: json["paymentFrequency"],
        signUpFee: json["signUpFee"].toDouble(),
        thirdParty: json["thirdParty"],
        thirdPartyPay: json["thirdPartyPay"],
      );

  Map<String, dynamic> toJson() => {
        "monitoringFee": monitoringFee,
        "paymentAmount": paymentAmount,
        "paymentFrequency": paymentFrequency,
        "signUpFee": signUpFee,
        "thirdParty": thirdParty,
        "thirdPartyPay": thirdPartyPay,
      };
}

class CheckInRequest {
  String? checkinPin;
  String? deadline;
  String? requestId;
  DateTime? requestTime;
  String? requestType;
  String? requestedById;
  bool? status;

  CheckInRequest({
    this.checkinPin,
    this.deadline,
    this.requestId,
    this.requestTime,
    this.requestType,
    this.requestedById,
    this.status,
  });

  factory CheckInRequest.fromJson(Map<String, dynamic> json) => CheckInRequest(
        checkinPin: json["checkinPin"],
        deadline: json["deadline"],
        requestId: json["requestId"],
        requestTime: json["requestTime"] == null ? null : DateTime.parse(json["requestTime"]),
        requestType: json["requestType"],
        requestedById: json["requestedById"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "checkinPin": checkinPin,
        "deadline": deadline,
        "requestId": requestId,
        "requestTime": requestTime?.toIso8601String(),
        "requestType": requestType,
        "requestedById": requestedById,
        "status": status,
      };
}

class ContactDetails {
  String? homeAddress;
  String? homeCity;
  String? homeCountry;
  double? homeLat;
  double? homeLng;
  String? homePhoneNumber;
  String? homePostalCode;
  String? homeProvince;
  int? homeRadius;

  ContactDetails({
    this.homeAddress,
    this.homeCity,
    this.homeCountry,
    this.homeLat,
    this.homeLng,
    this.homePhoneNumber,
    this.homePostalCode,
    this.homeProvince,
    this.homeRadius,
  });

  factory ContactDetails.fromJson(Map<String, dynamic> json) => ContactDetails(
        homeAddress: json["homeAddress"],
        homeCity: json["homeCity"],
        homeCountry: json["homeCountry"],
        homeLat: json["homeLat"]?.toDouble(),
        homeLng: json["homeLng"]?.toDouble(),
        homePhoneNumber: json["homePhoneNumber"],
        homePostalCode: json["homePostalCode"],
        homeProvince: json["homeProvince"],
        homeRadius: json["homeRadius"],
      );

  Map<String, dynamic> toJson() => {
        "homeAddress": homeAddress,
        "homeCity": homeCity,
        "homeCountry": homeCountry,
        "homeLat": homeLat,
        "homeLng": homeLng,
        "homePhoneNumber": homePhoneNumber,
        "homePostalCode": homePostalCode,
        "homeProvince": homeProvince,
        "homeRadius": homeRadius,
      };
}

class CourtAppearances {
  int? late;
  String? monitoringPeriod;
  int? outstanding;
  int? totalCheckins;
  int? voluntaryCheckins;

  CourtAppearances({
    this.late,
    this.monitoringPeriod,
    this.outstanding,
    this.totalCheckins,
    this.voluntaryCheckins,
  });

  factory CourtAppearances.fromJson(Map<String, dynamic> json) => CourtAppearances(
        late: json["late"],
        monitoringPeriod: json["monitoringPeriod"],
        outstanding: json["outstanding"],
        totalCheckins: json["totalCheckins"],
        voluntaryCheckins: json["voluntaryCheckins"],
      );

  Map<String, dynamic> toJson() => {
        "late": late,
        "monitoringPeriod": monitoringPeriod,
        "outstanding": outstanding,
        "totalCheckins": totalCheckins,
        "voluntaryCheckins": voluntaryCheckins,
      };
}

class PersonalDetails {
  String? age;
  String? alsoKnownAs;
  String? driverLicenceNo;
  String? driverLicenceState;
  String? eye;
  String? height;
  String? howLongInMonths;
  String? howLongInYears;
  String? materialStatus;
  String? other;
  String? race;
  String? rentOrOwn;
  String? sex;
  String? sourceOfIncome;
  String? usCitizen;
  String? usStatus;
  String? weight;

  PersonalDetails({
    this.age,
    this.alsoKnownAs,
    this.driverLicenceNo,
    this.driverLicenceState,
    this.eye,
    this.height,
    this.howLongInMonths,
    this.howLongInYears,
    this.materialStatus,
    this.other,
    this.race,
    this.rentOrOwn,
    this.sex,
    this.sourceOfIncome,
    this.usCitizen,
    this.usStatus,
    this.weight,
  });

  factory PersonalDetails.fromJson(Map<String, dynamic> json) => PersonalDetails(
        age: json["age"],
        alsoKnownAs: json["alsoKnownAs"],
        driverLicenceNo: json["driverLicenceNo"],
        driverLicenceState: json["driverLicenceState"],
        eye: json["eye"],
        height: json["height"],
        howLongInMonths: json["howLongInMonths"],
        howLongInYears: json["howLongInYears"],
        materialStatus: json["materialStatus"],
        other: json["other"],
        race: json["race"],
        rentOrOwn: json["rentOrOwn"],
        sex: json["sex"],
        sourceOfIncome: json["sourceOfIncome"],
        usCitizen: json["usCitizen"],
        usStatus: json["usStatus"],
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "age": age,
        "alsoKnownAs": alsoKnownAs,
        "driverLicenceNo": driverLicenceNo,
        "driverLicenceState": driverLicenceState,
        "eye": eye,
        "height": height,
        "howLongInMonths": howLongInMonths,
        "howLongInYears": howLongInYears,
        "materialStatus": materialStatus,
        "other": other,
        "race": race,
        "rentOrOwn": rentOrOwn,
        "sex": sex,
        "sourceOfIncome": sourceOfIncome,
        "usCitizen": usCitizen,
        "usStatus": usStatus,
        "weight": weight,
      };
}

class WorkDetails {
  String? employerName;
  String? workAddress;
  String? workCity;
  String? workCountry;
  double? workLat;
  double? workLng;
  String? workPhoneNumber;
  String? workPostalCode;
  String? workProvince;
  int? workRadius;

  WorkDetails({
    this.employerName,
    this.workAddress,
    this.workCity,
    this.workCountry,
    this.workLat,
    this.workLng,
    this.workPhoneNumber,
    this.workPostalCode,
    this.workProvince,
    this.workRadius,
  });

  factory WorkDetails.fromJson(Map<String, dynamic> json) => WorkDetails(
        employerName: json["employerName"],
        workAddress: json["workAddress"],
        workCity: json["workCity"],
        workCountry: json["workCountry"],
        workLat: json["workLat"]?.toDouble(),
        workLng: json["workLng"]?.toDouble(),
        workPhoneNumber: json["workPhoneNumber"],
        workPostalCode: json["workPostalCode"],
        workProvince: json["workProvince"],
        workRadius: json["workRadius"],
      );

  Map<String, dynamic> toJson() => {
        "employerName": employerName,
        "workAddress": workAddress,
        "workCity": workCity,
        "workCountry": workCountry,
        "workLat": workLat,
        "workLng": workLng,
        "workPhoneNumber": workPhoneNumber,
        "workPostalCode": workPostalCode,
        "workProvince": workProvince,
        "workRadius": workRadius,
      };
}
