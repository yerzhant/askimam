import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication.freezed.dart';
part 'authentication.g.dart';

@freezed
abstract class Authentication with _$Authentication {
  factory Authentication(
    String jwt,
    UserType userType,
  ) = _Authentication;

  factory Authentication.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationFromJson(json);
}

enum UserType { Imam, Inquirer }
