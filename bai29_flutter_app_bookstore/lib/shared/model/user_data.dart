class UserData {
  String displayName;
  String avatar;
  String token;

  UserData({
    required this.displayName,
    required this.avatar,
    required this.token,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      displayName: json["displayName"],
      avatar: json["avatar"],
      token: json["token"],
    );
  }

  // UserData.fromTada(Map<String, dynamic> json)
  //     : displayName = json["displayName"],
  //       avatar = json["avatar"],
  //       token = json["token"];
}
