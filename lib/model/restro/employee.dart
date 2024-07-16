class Employee {
  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  bool? isStaff;
  bool? isActive;
  DateTime? dateJoined;
  String? role;
  String? profilePic;
  String? contact;
  String? address;

  Employee({
     this.id,
     this.username,
     this.firstName,
     this.lastName,
     this.email,
     this.isStaff,
     this.isActive,
     this.dateJoined,
     this.role,
     this.profilePic,
     this.contact,
     this.address,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        username: json["username"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        isStaff: json["is_staff"],
        isActive: json["is_active"],
        dateJoined: DateTime.parse(json["date_joined"]),
        role: json["role"],
        profilePic: json["profile_pic"],
        contact: json["contact"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "is_staff": isStaff,
        "is_active": isActive,
        "role": role,
        "profile_pic": profilePic,
        "contact": contact,
        "address": address,
      };
}
