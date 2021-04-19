import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/common/domain/service/settings.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _jwt = 'jwt';
const _userType = 'user-type';

class LocalStorage implements Settings {
  @override
  Future<Option<Rejection>> clearAuthentication() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.remove(_jwt);
      await prefs.remove(_userType);

      return none();
    } on Exception catch (e) {
      return some(e.asRejection());
    }
  }

  @override
  Future<Either<Rejection, Authentication>> loadAuthentication() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final jwt = prefs.getString(_jwt);

      if (jwt != null) {
        final userType = UserType.values.firstWhere(
            (element) => element.toString() == prefs.getString(_userType));

        return right(Authentication(jwt, userType));
      }

      return left(Rejection('no-data'));
    } on Exception catch (e) {
      return left(e.asRejection());
    }
  }

  @override
  Future<Either<Rejection, Authentication>> saveAuthentication(
      Authentication authentication) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString(_jwt, authentication.jwt);
      await prefs.setString(_userType, authentication.userType.toString());

      return right(authentication);
    } on Exception catch (e) {
      return left(e.asRejection());
    }
  }
}
