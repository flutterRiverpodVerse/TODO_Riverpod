import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_riverpod/features/auth/domain/auth_failure.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.authenticated() = _Authenticated;
  const factory LoginState.unauthenticated() = _Unauthenticated;
  const factory LoginState.failure({
    required AuthFailure authFailure,
  }) = _Failure;
}
