import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  String? accessToken;

  @HiveField(1)
  String? refreshToken;

  @HiveField(2)
  int? pk;

  @HiveField(3)
  String? username;

  @HiveField(4)
  String? email;

  @HiveField(5)
  String? firstName;

  @HiveField(6)
  String? lastName;

  @HiveField(7)
  String? contact;

  @HiveField(8)
  String? profilePic;

  @HiveField(9)
  String? role;

  @HiveField(10)
  String? address;

  User({
    this.accessToken,
    this.refreshToken,
    this.pk,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.contact,
    this.profilePic,
    this.role,
    this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    var userJson = json['user'] as Map<String, dynamic>?;
    if (json['pk'] != null) {
      //from employee serializer
      userJson = json;
    }

    if (userJson != null) {
      return User(
        accessToken: json['access'] as String?,
        refreshToken: json['refresh'] as String?,
        pk: userJson['pk'] as int?,
        username: userJson['username'] as String?,
        email: userJson['email'] as String?,
        firstName: userJson['first_name'] as String?,
        lastName: userJson['last_name'] as String?,
        contact: userJson['contact'] as String?,
        profilePic: userJson['profile_pic'] as String?,
        role: userJson['role'] as String?,
        address: userJson['address'] as String?,
      );
    } else if (json['accessToken'] != null) {
      return User(
        accessToken: json['accessToken'] as String?,
        refreshToken: json['refreshToken'] as String?,
        pk: json['pk'] as int?,
        username: json['username'] as String?,
        email: json['email'] as String?,
        firstName: json['first_name'] as String?,
        lastName: json['last_name'] as String?,
        contact: json['contact'] as String?,
        profilePic: json['profilePic'] as String?,
        role: json['role'] as String?,
        address: json['address'] as String?,
      );
    } else {
      throw Exception('User data is missing from the response');
    }
  }

  String getFullName() {
    return '$firstName $lastName';
  }
}
