class AlertsModel {
  String? alertId;
  String? description;
  bool? readStatus;
  DateTime? timestamp;
  String? uniqueId;

  AlertsModel({this.alertId, this.description, this.readStatus, this.timestamp, this.uniqueId});

  factory AlertsModel.fromJson(Map<String, dynamic> json) => AlertsModel(
        alertId: json["alertId"],
        description: json["description"],
        readStatus: json["readStatus"],
        timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
        uniqueId: json["uniqueId"],
      );

  Map<String, dynamic> toJson() => {
        "alertId": alertId,
        "description": description,
        "readStatus": readStatus,
        "timestamp": timestamp?.toIso8601String(),
        "uniqueId": uniqueId,
      };
}
