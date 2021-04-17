// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'api_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) {
  return _ApiResponse.fromJson(json);
}

/// @nodoc
class _$ApiResponseTearOff {
  const _$ApiResponseTearOff();

  _ApiResponse call(ApiResponseStatus status, {Object? data, String? error}) {
    return _ApiResponse(
      status,
      data: data,
      error: error,
    );
  }

  ApiResponse fromJson(Map<String, Object> json) {
    return ApiResponse.fromJson(json);
  }
}

/// @nodoc
const $ApiResponse = _$ApiResponseTearOff();

/// @nodoc
mixin _$ApiResponse {
  ApiResponseStatus get status => throw _privateConstructorUsedError;
  Object? get data => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApiResponseCopyWith<ApiResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiResponseCopyWith<$Res> {
  factory $ApiResponseCopyWith(
          ApiResponse value, $Res Function(ApiResponse) then) =
      _$ApiResponseCopyWithImpl<$Res>;
  $Res call({ApiResponseStatus status, Object? data, String? error});
}

/// @nodoc
class _$ApiResponseCopyWithImpl<$Res> implements $ApiResponseCopyWith<$Res> {
  _$ApiResponseCopyWithImpl(this._value, this._then);

  final ApiResponse _value;
  // ignore: unused_field
  final $Res Function(ApiResponse) _then;

  @override
  $Res call({
    Object? status = freezed,
    Object? data = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ApiResponseStatus,
      data: data == freezed ? _value.data : data,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$ApiResponseCopyWith<$Res>
    implements $ApiResponseCopyWith<$Res> {
  factory _$ApiResponseCopyWith(
          _ApiResponse value, $Res Function(_ApiResponse) then) =
      __$ApiResponseCopyWithImpl<$Res>;
  @override
  $Res call({ApiResponseStatus status, Object? data, String? error});
}

/// @nodoc
class __$ApiResponseCopyWithImpl<$Res> extends _$ApiResponseCopyWithImpl<$Res>
    implements _$ApiResponseCopyWith<$Res> {
  __$ApiResponseCopyWithImpl(
      _ApiResponse _value, $Res Function(_ApiResponse) _then)
      : super(_value, (v) => _then(v as _ApiResponse));

  @override
  _ApiResponse get _value => super._value as _ApiResponse;

  @override
  $Res call({
    Object? status = freezed,
    Object? data = freezed,
    Object? error = freezed,
  }) {
    return _then(_ApiResponse(
      status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ApiResponseStatus,
      data: data == freezed ? _value.data : data,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_ApiResponse extends _ApiResponse {
  const _$_ApiResponse(this.status, {this.data, this.error}) : super._();

  factory _$_ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$_$_ApiResponseFromJson(json);

  @override
  final ApiResponseStatus status;
  @override
  final Object? data;
  @override
  final String? error;

  @override
  String toString() {
    return 'ApiResponse(status: $status, data: $data, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ApiResponse &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)) &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(data) ^
      const DeepCollectionEquality().hash(error);

  @JsonKey(ignore: true)
  @override
  _$ApiResponseCopyWith<_ApiResponse> get copyWith =>
      __$ApiResponseCopyWithImpl<_ApiResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ApiResponseToJson(this);
  }
}

abstract class _ApiResponse extends ApiResponse {
  const factory _ApiResponse(ApiResponseStatus status,
      {Object? data, String? error}) = _$_ApiResponse;
  const _ApiResponse._() : super._();

  factory _ApiResponse.fromJson(Map<String, dynamic> json) =
      _$_ApiResponse.fromJson;

  @override
  ApiResponseStatus get status => throw _privateConstructorUsedError;
  @override
  Object? get data => throw _privateConstructorUsedError;
  @override
  String? get error => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ApiResponseCopyWith<_ApiResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
