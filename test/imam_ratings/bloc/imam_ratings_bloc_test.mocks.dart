// Mocks generated by Mockito 5.4.4 from annotations
// in askimam/test/imam_ratings/bloc/imam_ratings_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:askimam/common/domain/model/rejection.dart' as _i5;
import 'package:askimam/imam_ratings/domain/model/imam_ratings_with_description.dart'
    as _i6;
import 'package:askimam/imam_ratings/domain/repo/imam_ratings_repo.dart' as _i3;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ImamRatingsRepo].
///
/// See the documentation for Mockito's code generation for more information.
class MockImamRatingsRepo extends _i1.Mock implements _i3.ImamRatingsRepo {
  MockImamRatingsRepo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Rejection, _i6.ImamRatingsWithDescription>>
      getRatings() => (super.noSuchMethod(
            Invocation.method(
              #getRatings,
              [],
            ),
            returnValue: _i4.Future<
                    _i2.Either<_i5.Rejection,
                        _i6.ImamRatingsWithDescription>>.value(
                _FakeEither_0<_i5.Rejection, _i6.ImamRatingsWithDescription>(
              this,
              Invocation.method(
                #getRatings,
                [],
              ),
            )),
          ) as _i4.Future<
              _i2.Either<_i5.Rejection, _i6.ImamRatingsWithDescription>>);
}
