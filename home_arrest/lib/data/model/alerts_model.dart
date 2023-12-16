class AlertsModel {
  String? alertId;
  String? description;
  String? fullName;
  String? profilePic;
  bool? readStatus;
  DateTime? timestamp;
  String? uniqueId;
  String? alertsModelUniqueId;

  AlertsModel({
    this.alertId,
    this.description,
    this.fullName,
    this.profilePic,
    this.readStatus,
    this.timestamp,
    this.uniqueId,
    this.alertsModelUniqueId,
  });

  factory AlertsModel.fromJson(Map<String, dynamic> json) => AlertsModel(
        alertId: json["alertId"],
        description: json["description"],
        fullName: json["fullName"],
        profilePic: json["profilePic"],
        readStatus: json["readStatus"],
        timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
        uniqueId: json["uniqueID"],
        alertsModelUniqueId: json["uniqueId"],
      );

  Map<String, dynamic> toJson() => {
        "alertId": alertId,
        "description": description,
        "fullName": fullName,
        "profilePic": profilePic,
        "readStatus": readStatus,
        "timestamp": timestamp?.toIso8601String(),
        "uniqueID": uniqueId,
        "uniqueId": alertsModelUniqueId,
      };
}
