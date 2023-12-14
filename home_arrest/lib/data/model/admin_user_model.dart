import 'location_model.dart';

class AdminUserModel {
  List<String>? clientsAssigned;
  String? email;
  String? firstName;
  String? gender;
  String? lastName;
  Location? location;
  String? phoneNumber;
  String? profilePic;
  int? role;
  String? roleName;
  String? uniqueId;
  String? userName;

  AdminUserModel({
    this.clientsAssigned,
    this.email,
    this.firstName,
    this.gender,
    this.lastName,
    this.location,
    this.phoneNumber,
    this.profilePic,
    this.role,
    this.roleName,
    this.uniqueId,
    this.userName,
  });

  factory AdminUserModel.fromJson(Map<String, dynamic> json) => AdminUserModel(
        clientsAssigned: json["clientsAssigned"] == null ? [] : List<String>.from(json["clientsAssigned"]!.map((x) => x)),
        email: json["email"],
        firstName: json["firstName"],
        gender: json["gender"],
        lastName: json["lastName"],
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        phoneNumber: json["phoneNumber"],
        profilePic: json["profilePic"],
        role: json["role"],
        roleName: json["roleName"],
        uniqueId: json["uniqueId"],
        userName: json["userName"],
      );

  Map<String, dynamic> toJson() => {
        if (clientsAssigned != null) "clientsAssigned": List<dynamic>.from(clientsAssigned!.map((x) => x)),
        if (email != null) "email": email,
        if (firstName != null) "firstName": firstName,
        if (gender != null) "gender": gender,
        if (lastName != null) "lastName": lastName,
        if (location != null) "location": location?.toJson(),
        if (phoneNumber != null) "phoneNumber": phoneNumber,
        if (profilePic != null) "profilePic": profilePic,
        if (role != null) "role": role,
        if (roleName != null) "roleName": roleName,
        if (uniqueId != null) "uniqueId": uniqueId,
        if (userName != null) "userName": userName,
      };
}
