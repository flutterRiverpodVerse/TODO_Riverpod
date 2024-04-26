import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/core/shared/providers.dart';
import 'package:todo_riverpod/features/auth/domain/user_model.dart';
import 'package:todo_riverpod/features/profile/infra/profile_remote_services.dart';

final profileRemoteServicesProvider = Provider<ProfileRemoteServices>(
  (ref) => ProfileRemoteServices(
    firebaseAuth: ref.watch(firebaseAuthProvider),
    firebaseFirestore: ref.watch(firebaseFirestoreProvider),
    getStorage: ref.watch(getStorageProvider),
  ),
);

final userDataProvider = FutureProvider<UserModel>(
  (
    ref,
  ) async {
    final userData = ref.watch(profileRemoteServicesProvider).getUserData();
    return userData;
  },
);
