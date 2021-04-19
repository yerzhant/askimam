import 'package:askimam/common/domain/model/model.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:dartz/dartz.dart';

abstract class ApiClient {
  Future<Either<Rejection, M>> get<M extends Model>(String suffix);
  Future<Either<Rejection, List<M>>> getList<M extends Model>(String suffix);

  Future<Option<Rejection>> post<M extends Model>(String suffix, M model);
  Future<Option<Rejection>> patch(String suffix);
  Future<Option<Rejection>> delete(String suffix);

  Future<Option<Rejection>> patchWithBody<M extends Model>(
      String suffix, M model);

  Future<Either<Rejection, R>>
      postAndGetResponse<R extends Model, M extends Model>(
          String suffix, M model);

  void close();
}
