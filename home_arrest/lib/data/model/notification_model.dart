class Notifications {
  Authentication? authentication;
  Authentication? braceletBattery;
  Authentication? braceletConnection;
  Authentication? exclusionZone;
  Authentication? gpsLocation;
  Authentication? missing;
  Authentication? noReply;
  Authentication? outsideZone;
  Authentication? phoneBattery;
  Authentication? sobriety;

  Notifications({
    this.authentication,
    this.braceletBattery,
    this.braceletConnection,
    this.exclusionZone,
    this.gpsLocation,
    this.missing,
    this.noReply,
    this.outsideZone,
    this.phoneBattery,
    this.sobriety,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        authentication: json["authentication"] == null ? null : Authentication.fromJson(json["authentication"]),
        braceletBattery: json["braceletBattery"] == null ? null : Authentication.fromJson(json["braceletBattery"]),
        braceletConnection: json["braceletConnection"] == null ? null : Authentication.fromJson(json["braceletConnection"]),
        exclusionZone: json["exclusionZone"] == null ? null : Authentication.fromJson(json["exclusionZone"]),
        gpsLocation: json["gpsLocation"] == null ? null : Authentication.fromJson(json["gpsLocation"]),
        missing: json["missing"] == null ? null : Authentication.fromJson(json["missing"]),
        noReply: json["noReply"] == null ? null : Authentication.fromJson(json["noReply"]),
        outsideZone: json["outsideZone"] == null ? null : Authentication.fromJson(json["outsideZone"]),
        phoneBattery: json["phoneBattery"] == null ? null : Authentication.fromJson(json["phoneBattery"]),
        sobriety: json["sobriety"] == null ? null : Authentication.fromJson(json["sobriety"]),
      );

  Map<String, dynamic> toJson() => {
        "authentication": authentication?.toJson(),
        "braceletBattery": braceletBattery?.toJson(),
        "braceletConnection": braceletConnection?.toJson(),
        "exclusionZone": exclusionZone?.toJson(),
        "gpsLocation": gpsLocation?.toJson(),
        "missing": missing?.toJson(),
        "noReply": noReply?.toJson(),
        "outsideZone": outsideZone?.toJson(),
        "phoneBattery": phoneBattery?.toJson(),
        "sobriety": sobriety?.toJson(),
      };
}

class Authentication {
  bool? email;
  bool? pushNotification;

  Authentication({
    this.email,
    this.pushNotification,
  });

  factory Authentication.fromJson(Map<String, dynamic> json) => Authentication(
        email: json["email"],
        pushNotification: json["pushNotification"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "pushNotification": pushNotification,
      };
}
