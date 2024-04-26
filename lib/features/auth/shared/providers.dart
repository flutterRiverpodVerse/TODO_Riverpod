import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/core/shared/providers.dart';
import 'package:todo_riverpod/features/auth/application/login_notifier.dart';
import 'package:todo_riverpod/features/auth/application/logout_notifier.dart';
import 'package:todo_riverpod/features/auth/domain/login_state.dart';
import 'package:todo_riverpod/features/auth/domain/logout_state.dart';
import 'package:todo_riverpod/features/auth/infra/auth_remote_services.dart';

final authRemoteServicesProvider = Provider<AuthRemoteServices>(
  (ref) => AuthRemoteServices(
    googleSignIn: ref.watch(googleSignInProvider),
    firebaseAuth: ref.watch(firebaseAuthProvider),
    firebaseFirestore: ref.watch(firebaseFirestoreProvider),
    getStorage: ref.watch(getStorageProvider),
  ),
);

final loginNotifierProvider =
    StateNotifierProvider.autoDispose<LoginNotifier, LoginState>(
  (ref) {
    return LoginNotifier(
      const LoginState.initial(),
      authRemoteServices: ref.watch(authRemoteServicesProvider),
    );
  },
);
final logoutNotifierProvider =
    StateNotifierProvider.autoDispose<LogoutNotifier, LogoutState>(
  (ref) {
    return LogoutNotifier(
      const LogoutState.initial(),
      authRemoteServices: ref.watch(authRemoteServicesProvider),
    );
  },
);
