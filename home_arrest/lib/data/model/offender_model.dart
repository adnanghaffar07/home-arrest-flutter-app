import 'location_model.dart';

class OffendorModel {
  String? image;
  String? active;
  String? addedBy;
  String? agentAssigned;
  AgentDetails? agentDetails;
  HomeAddressDetails? homeAddressDetails;
  WorkAddressDetails? workAddressDetails;
  String? checkIn;
  String? clientType;
  CourtAppearances? courtAppearances;
  String? dateOfBirth;
  DateTime? dateOfEntry;
  String? emailAddress;
  String? firstName;
  String? lastName;
  Location? location;
  String? maidenName;
  String? middleName;
  String? monitorLevel;
  String? phoneNumber;
  CourtAppearances? recentAlerts;
  CourtAppearances? scoreCard;
  String? sentenceEndDate;
  String? sentenceStartDate;
  String? ssn;
  String? uniqueId;
  String? profilePic;
  bool isSelected = false;

  OffendorModel({
    this.image,
    this.active,
    this.addedBy,
    this.agentAssigned,
    this.agentDetails,
    this.checkIn,
    this.clientType,
    this.courtAppearances,
    this.dateOfBirth,
    this.dateOfEntry,
    this.emailAddress,
    this.firstName,
    this.lastName,
    this.location,
    this.maidenName,
    this.middleName,
    this.monitorLevel,
    this.phoneNumber,
    this.recentAlerts,
    this.scoreCard,
    this.sentenceEndDate,
    this.sentenceStartDate,
    this.ssn,
    this.uniqueId,
    this.homeAddressDetails,
    this.workAddressDetails,
    this.profilePic,
    this.isSelected = false,
  });

  factory OffendorModel.fromJson(Map<String, dynamic> json) => OffendorModel(
        active: json["active"],
        addedBy: json["addedBy"],
        agentAssigned: json["agentAssigned"],
        agentDetails: json["agentDetails"] == null ? null : AgentDetails.fromJson(json["agentDetails"]),
        checkIn: json["checkIn"],
        homeAddressDetails: json["contactDetails"] == null ? null : HomeAddressDetails.fromJson(json["contactDetails"]),
        workAddressDetails: json["workDetails"] == null ? null : WorkAddressDetails.fromJson(json["workDetails"]),
        clientType: json["clientType"],
        courtAppearances: json["courtAppearances"] == null ? null : CourtAppearances.fromJson(json["courtAppearances"]),
        dateOfBirth: json["dateOfBirth"],
        dateOfEntry: json["dateOfEntry"] == null ? null : DateTime.parse(json["dateOfEntry"]),
        emailAddress: json["emailAddress"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        maidenName: json["maidenName"],
        middleName: json["middleName"],
        monitorLevel: json["monitorLevel"] != null
            ? json["monitorLevel"] == 1
                ? "Low"
                : json["monitorLevel"] == 2
                    ? "Medium"
                    : "High"
            : null,
        phoneNumber: json["phoneNumber"],
        recentAlerts: json["recentAlerts"] == null ? null : CourtAppearances.fromJson(json["recentAlerts"]),
        scoreCard: json["scoreCard"] == null ? null : CourtAppearances.fromJson(json["scoreCard"]),
        sentenceEndDate: json["sentenceEndDate"],
        sentenceStartDate: json["sentenceStartDate"],
        ssn: json["ssn"],
        uniqueId: json["uniqueId"],
        profilePic: json["profilePic"],
      );

  Map<String, dynamic> toJson() => {
        if (active != null) "active": active,
        if (addedBy != null) "addedBy": addedBy,
        if (agentAssigned != null) "agentAssigned": agentAssigned,
        if (agentDetails != null) "agentDetails": agentDetails?.toJson(),
        if (checkIn != null) "checkIn": checkIn,
        if (checkIn != null) "clientType": checkIn,
        if (courtAppearances != null) "courtAppearances": courtAppearances?.toJson(),
        if (dateOfBirth != null) "dateOfBirth": dateOfBirth,
        if (dateOfEntry != null) "dateOfEntry": dateOfEntry?.toIso8601String(),
        if (emailAddress != null) "emailAddress": emailAddress,
        if (firstName != null) "firstName": firstName,
        if (lastName != null) "lastName": lastName,
        if (location != null) "location": location?.toJson(),
        if (maidenName != null) "maidenName": maidenName,
        if (middleName != null) "middleName": middleName,
        if (monitorLevel != null) "monitorLevel": monitorLevel!.toLowerCase() == "low" ? 1 : monitorLevel!.toLowerCase() == "medium" ? 2 : 3,
        if (phoneNumber != null) "phoneNumber": phoneNumber,
        if (recentAlerts != null) "recentAlerts": recentAlerts?.toJson(),
        if (scoreCard != null) "scoreCard": scoreCard?.toJson(),
        if (sentenceEndDate != null) "sentenceEndDate": sentenceEndDate,
        if (sentenceStartDate != null) "sentenceStartDate": sentenceStartDate,
        if (ssn != null) "ssn": ssn,
        if (uniqueId != null) "uniqueId": uniqueId,
      };
}

class AgentDetails {
  String? email;
  String? firstName;
  String? gender;
  String? lastName;
  String? phoneNumber;
  int? role;
  String? uniqueId;
  String? userName;

  AgentDetails({this.email, this.firstName, this.gender, this.lastName, this.phoneNumber, this.role, this.uniqueId, this.userName});

  factory AgentDetails.fromJson(Map<String, dynamic> json) => AgentDetails(
        email: json["email"],
        firstName: json["firstName"],
        gender: json["gender"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        role: json["role"],
        uniqueId: json["uniqueId"],
        userName: json["userName"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "firstName": firstName,
        "gender": gender,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "role": role,
        "uniqueId": uniqueId,
        "userName": userName,
      };
}

class CourtAppearances {
  int? late;
  String? monitoringPeriod;
  int? outstanding;
  int? totalCheckins;
  int? voluntaryCheckins;

  CourtAppearances({this.late, this.monitoringPeriod, this.outstanding, this.totalCheckins, this.voluntaryCheckins});

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

class HomeAddressDetails {
  String? homeAddress;
  String? homeCity;
  String? homeCountry;
  double? homeLat;
  double? homeLng;
  String? homePhoneNumber;
  String? homePostalCode;
  String? homeProvince;
  int? homeRadius;

  HomeAddressDetails({
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

  factory HomeAddressDetails.fromJson(Map<String, dynamic> json) => HomeAddressDetails(
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

class WorkAddressDetails {
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

  WorkAddressDetails({
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

  factory WorkAddressDetails.fromJson(Map<String, dynamic> json) => WorkAddressDetails(
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
