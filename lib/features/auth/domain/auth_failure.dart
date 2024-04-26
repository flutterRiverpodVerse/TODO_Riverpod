import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.freezed.dart';

@freezed
class AuthFailure with _$AuthFailure {
  const factory AuthFailure.cancelledByUser({
    required String message,
  }) = _CancelledByUser;
  const factory AuthFailure.serverError({
    required String message,
  }) = _ServerError;
}
