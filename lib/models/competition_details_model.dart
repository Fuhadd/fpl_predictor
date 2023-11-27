import 'package:fpl_predictor/models/user_selection_model.dart';

class CompetitionDetailsModel {
  CompetitionDetailsModel({
    this.id = "",
    this.compName = "",
    this.leagueId = 0,
    this.leagueName = "",
    this.sportId = 0,
    this.sportName = "",
    this.userSelections,
    this.finalResults,
  });

  String id;
  String compName;
  int leagueId;
  String leagueName;
  int sportId;
  String sportName;
  List<UserSelectionModel>? userSelections;
  List<String>? finalResults;

  factory CompetitionDetailsModel.fromJson(json) => CompetitionDetailsModel(
        id: json["id"] ?? "",
        compName: json["compName"] ?? "",
        leagueId: json["leagueId"] ?? 0,
        leagueName: json["leagueName"] ?? "",
        sportId: json["sportId"] ?? 0,
        sportName: json["sportName"] ?? "",
        userSelections: (json["userSelections"] as List<dynamic>)
            .map((json) => UserSelectionModel.fromJson(json))
            .toList(),
        finalResults: (json["finalResults"] as List<dynamic>)
            .map((json) => json.toString())
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "compName": compName,
        "leagueId": leagueId,
        "leagueName": leagueName,
        "sportId": sportId,
        "sportName": sportName,
        "userSelections": userSelections == null
            ? []
            : userSelections!
                .map((userSelectionModel) => userSelectionModel.toJson())
                .toList(),
        "finalResults": finalResults,
      };
}
