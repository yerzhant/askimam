import 'package:askimam/common/domain/model/model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'authentication.g.dart';

@JsonSerializable()
class Authentication extends Equatable with Model {
  final String jwt;
  final int userId;
  final UserType userType;

  const Authentication(this.jwt, this.userId, this.userType);

  factory Authentication.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AuthenticationToJson(this);

  @override
  List<Object?> get props => [jwt, userId, userType];
}

// ignore: constant_identifier_names
enum UserType { Imam, Inquirer }
