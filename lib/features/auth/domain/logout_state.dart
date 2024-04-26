import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_riverpod/features/auth/domain/auth_failure.dart';

part 'logout_state.freezed.dart';

@freezed
class LogoutState with _$LogoutState {
  const factory LogoutState.initial() = _Initial;
  const factory LogoutState.success() = _Success;
  const factory LogoutState.failure({
    required AuthFailure authFailure,
  }) = _Failure;
}
