class RestroInfo {
  int id;
  String name;
  String address;
  String contact;
  String email;
  String description;
  String logo;
  DateTime createdAt;

  RestroInfo({
    required this.id,
    required this.name,
    required this.address,
    required this.contact,
    required this.email,
    required this.description,
    required this.logo,
    required this.createdAt,
  });

  factory RestroInfo.fromJson(Map<String, dynamic> json) => RestroInfo(
        id: json["id"],
        name: json["restaurant_name"],
        address: json["restaurant_address"],
        contact: json["restaurant_contact"],
        email: json["restaurant_email"],
        description: json["restaurant_description"],
        logo: json["restaurant_logo"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "restaurant_name": name,
        "restaurant_address": address,
        "restaurant_contact": contact,
        "restaurant_email": email,
        "restaurant_description": description,
        "restaurant_logo": logo,
        "created_at": createdAt.toIso8601String(),
      };
}
