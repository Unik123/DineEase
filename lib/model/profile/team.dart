class Team {
  int id;
  String name;
  String role;
  String image;
  DateTime createdAt;

  Team({
    required this.id,
    required this.name,
    required this.role,
    required this.image,
    required this.createdAt,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["id"],
        name: json["name"],
        role: json["role"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "role": role,
        "image": image,
        "created_at": createdAt.toIso8601String(),
      };
}
