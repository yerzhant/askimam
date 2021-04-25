import 'package:askimam/common/domain/model/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication.freezed.dart';
part 'authentication.g.dart';

@freezed
class Authentication with _$Authentication, Model {
  factory Authentication(
    String jwt,
    int userId,
    UserType userType,
  ) = _Authentication;

  const Authentication._();

  factory Authentication.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationFromJson(json);
}

enum UserType { Imam, Inquirer }
