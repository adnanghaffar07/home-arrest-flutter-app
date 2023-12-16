class CheckInModel {
  String? checkinPin;
  String? deadline;
  String? requestId;
  DateTime? requestTime;
  String? requestType;
  String? requestedById;
  bool? status;

  CheckInModel({
    this.checkinPin,
    this.deadline,
    this.requestId,
    this.requestTime,
    this.requestType,
    this.requestedById,
    this.status,
  });

  factory CheckInModel.fromJson(Map<String, dynamic> json) => CheckInModel(
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
