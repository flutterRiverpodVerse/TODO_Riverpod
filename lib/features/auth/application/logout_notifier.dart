import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/features/auth/domain/logout_state.dart';
import 'package:todo_riverpod/features/auth/infra/auth_remote_services.dart';

class LogoutNotifier extends StateNotifier<LogoutState> {
  LogoutNotifier(
    super.state, {
    required this.authRemoteServices,
  });
  final AuthRemoteServices authRemoteServices;

  Future<void> logout({
    required BuildContext context,
  }) async {
    final data = await authRemoteServices.logout(context: context);

    state = data.fold(
      (authFailure) => LogoutState.failure(
        authFailure: authFailure,
      ),
      (r) => const LogoutState.success(),
    );
  }
}
