class UserSelectionModel {
  UserSelectionModel({
    this.playerId = "",
    this.playerName = "",
    this.userId = "",
    this.userName = "",
  });

  String playerId;
  String playerName;
  String userId;
  String userName;

  factory UserSelectionModel.fromJson(json) => UserSelectionModel(
        playerId: json["playerId"] ?? "",
        playerName: json["playerName"] ?? "",
        userId: json["userId"] ?? "",
        userName: json["userName"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "playerId": playerId,
        "playerName": playerName,
        "userId": userId,
        "userName": userName,
      };
}
