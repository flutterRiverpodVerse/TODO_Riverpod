import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/features/auth/domain/login_state.dart';
import 'package:todo_riverpod/features/auth/infra/auth_remote_services.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier(
    super.state, {
    required this.authRemoteServices,
  });
  final AuthRemoteServices authRemoteServices;

  Future<void> signInWithGoogle({
    required BuildContext context,
  }) async {
    final data = await authRemoteServices.signInWithGoogle(context: context);

    state = data.fold(
      (authFailure) => LoginState.failure(
        authFailure: authFailure,
      ),
      (r) => const LoginState.authenticated(),
    );
  }

  Future<void> isUserLoggedIn() async {
    state = await authRemoteServices.isUserLoggedIn()
        ? const LoginState.authenticated()
        : const LoginState.unauthenticated();
  }
}
