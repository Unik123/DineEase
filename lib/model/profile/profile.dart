class Profile {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? role;
  String? profilePic;
  String? contact;
  String? address;

  Profile({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.role,
    this.profilePic,
    this.contact,
    this.address,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        email: json["email"],
        role: json["role"],
        profilePic: json["profile_pic"],
        contact: json["contact"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "email": email,
        "role": role,
        "profile_pic": profilePic,
        "contact": contact,
        "address": address,
      };
}
