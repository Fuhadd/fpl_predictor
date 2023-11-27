class UserDataModel {
  UserDataModel({
    this.id = "",
    this.email = "",
    this.password = "",
    this.teamName = "",
    this.accountBalance = 0,
    this.leagues = const [],
    this.selections = const [],
  });

  String id;
  String email;
  String teamName;
  String password;
  int accountBalance;
  List<String> leagues;
  List<String> selections;

  factory UserDataModel.fromJson(json) => UserDataModel(
        id: json["id"] ?? "",
        password: json["password"] ?? "",
        email: json["email"] ?? "",
        teamName: json["teamName"] ?? "",
        accountBalance: json["accountBalance"] ?? 0,
        // leagues: (json["leagues"] as List<String>?) ?? [],
        // selections: (json["selections"] as List<String>?) ?? [],
        // timeLog: (json["timeLog"] as List<dynamic>?)
        //         ?.map((e) => TimeLog.fromJson(e))
        //         .toList() ??
        //     [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "password": password,
        "email": email,
        "teamName": teamName,
        "accountBalance": accountBalance,
        "leagues": leagues,
        "selections": selections,
      };
}
