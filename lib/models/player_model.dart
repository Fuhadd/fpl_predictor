class Player {
  final String? id;
  final String name;
  final String position;
  final String teamId;

  Player({
    this.id,
    required this.name,
    required this.position,
    required this.teamId,
  });

  static Player fromJson(json) => Player(
        id: json['id'] ?? "",
        position: json['position'],
        name: json['name'],
        teamId: json['teamId'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "position": position,
        "teamId": teamId,
      };
}
