class Team {
  final String? id;
  final String name;
  List<dynamic> players;

  Team({
    this.id,
    required this.name,
    required this.players,
  });

  static Team fromJson(json) => Team(
        id: json['id'] ?? "",
        name: json['name'],
        players: json['players'] ?? [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
