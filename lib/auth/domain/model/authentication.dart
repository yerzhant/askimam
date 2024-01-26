import 'package:askimam/common/domain/model/model.dart';
import 'package:equatable/equatable.dart';

class Authentication extends Equatable with Model {
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

  @override
  List<Object?> get props => [jwt, userId, userType];
}

enum UserType { Imam, Inquirer }
