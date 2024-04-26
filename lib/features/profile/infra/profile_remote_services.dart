// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_riverpod/core/constants/app_colors.dart';
import 'package:todo_riverpod/core/constants/app_config.dart';
import 'package:todo_riverpod/core/constants/app_constants.dart';
import 'package:todo_riverpod/features/auth/domain/user_model.dart';
import 'package:todo_riverpod/features/profile/domain/ab_profile_remote_services.dart';

class ProfileRemoteServices extends AbProfileRemoteServices {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final GetStorage getStorage;

  ProfileRemoteServices({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.getStorage,
  });

  @override
  Future<UserModel> getUserData() async {
    UserModel userData = UserModel.empty();
    try {
      final user = getStorage.read(AppConfig.user);

      if (user == null) {
        final data = await firebaseFirestore
            .collection('users')
            .doc(firebaseAuth.currentUser!.uid)
            .get();
        userData = UserModel.fromSnapshot(
          data,
        );
        await getStorage.write(AppConfig.user, userData.toJson());
      } else {
        userData = UserModel.fromJson(user);
      }
    } catch (e) {
      AppConstants.showSnackbar(
        backgroundColor: AppColors.error,
        text: e.toString(),
      );
    }
    return userData;
  }
}
