import 'package:ropstem_task/services/user_database.dart';

class UserModel {
  late final String id;
  late String name;
  late String email;
  late String password;
  late bool isLoggedIn;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.isLoggedIn = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['display_name'] ?? 'Unknown',
      email: json['user_email'] ?? 'Unknown',
      password: json['password'],
      isLoggedIn: json['isLoggedIn'],
    );
  }

  UserModel updateUser({
    String? name,
    String? email,
  }) {
    this.name = name ?? this.name;
    this.email = email ?? this.email;
    return clone();
  }

  UserModel.fromSource(source) {
    id = source.id;
    name = source.name;
    email = source.email;
  }

  UserModel clone() {
    return UserModel.fromSource(this);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'display_name': name, 'user_email': email, 'password': password,
      'isLoggedIn': isLoggedIn,
    };
  }
}
