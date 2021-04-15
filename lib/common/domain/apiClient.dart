import 'package:askimam/common/domain/rejection.dart';
import 'package:dartz/dartz.dart';

abstract class ApiClient {
  Future<Either<Rejection, List<T>>> getList<T>(String suffix);

  Future<Option<Rejection>> delete(String suffix);
}
