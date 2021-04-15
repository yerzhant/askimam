import 'package:askimam/common/domain/rejection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rejection_exception.freezed.dart';

@freezed
abstract class RejectionException with _$RejectionException {
  factory RejectionException(Rejection rejection) = _RejectionException;
}
