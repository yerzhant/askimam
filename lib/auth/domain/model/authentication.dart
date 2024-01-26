import 'package:askimam/common/domain/model/model.dart';

class Authentication with Model {
  final String jwt;
  final int userId;
  final UserType userType;

  const Authentication(this.jwt, this.userId, this.userType);

  factory Authentication.fromJson(Map<String, dynamic> json) =>
      Authentication(json['jwt'], json['userId'], json['userType']);

  @override
  Map<String, dynamic> toJson() => {
        'jwt': jwt,
        'userId': userId,
        'userType': userType,
      };
}

enum UserType { Imam, Inquirer }
