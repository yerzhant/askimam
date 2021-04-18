import 'package:askimam/common/domain/model.dart';
import 'package:askimam/common/domain/rejection.dart';
import 'package:dartz/dartz.dart';

abstract class ApiClient {
  Future<Either<Rejection, List<M>>> getList<M extends Model>(String suffix);
  Future<Option<Rejection>> post<M extends Model>(String suffix, M model);
  Future<Option<Rejection>> delete(String suffix);
}
