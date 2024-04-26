// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_riverpod/core/constants/app_config.dart';
import 'package:todo_riverpod/core/widgets/loader.dart';
import 'package:todo_riverpod/features/auth/domain/ab_auth_remote_services.dart';
import 'package:todo_riverpod/features/auth/domain/auth_failure.dart';
import 'package:todo_riverpod/features/auth/domain/user_model.dart';

class AuthRemoteServices extends AbAuthRemoteServices {
  final GoogleSignIn googleSignIn;
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final GetStorage getStorage;

  AuthRemoteServices({
    required this.googleSignIn,
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.getStorage,
  });
  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle({
    required BuildContext context,
  }) async {
    try {
      final googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        Loader.openLoadingDialog(context: context);
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        await firebaseAuth
            .signInWithCredential(credential)
            .whenComplete(() async {
          if (firebaseAuth.currentUser != null) {
            final newUser = UserModel(
              id: firebaseAuth.currentUser!.uid,
              name: firebaseAuth.currentUser!.displayName!,
              email: firebaseAuth.currentUser!.email!,
              profileImage: firebaseAuth.currentUser!.photoURL!,
            );
            final userDocRef = firebaseFirestore
                .collection('users')
                .doc(firebaseAuth.currentUser!.uid);
            final userDocSnapshot = await userDocRef.get();

            if (!userDocSnapshot.exists) {
              await userDocRef.set(
                newUser.toJson(),
              );
            }
          }
          Loader.stopLoading(context: context);
        });
      } else {
        return left(
          const AuthFailure.cancelledByUser(
            message: 'User cancelled the sign-in process',
          ),
        );
      }

      return right(unit);
    } on FirebaseAuthException catch (e) {
      Loader.stopLoading(context: context);
      return left(
        AuthFailure.serverError(
          message: e.toString(),
        ),
      );
    } on FirebaseException catch (e) {
      Loader.stopLoading(context: context);
      return left(
        AuthFailure.serverError(
          message: e.toString(),
        ),
      );
    } on PlatformException catch (e) {
      Loader.stopLoading(context: context);
      return left(
        AuthFailure.serverError(
          message: e.toString(),
        ),
      );
    } catch (e) {
      Loader.stopLoading(context: context);
      return left(
        AuthFailure.serverError(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<bool> isUserLoggedIn() async {
    return firebaseAuth.currentUser?.uid != null;
  }

  @override
  Future<Either<AuthFailure, Unit>> logout({
    required BuildContext context,
  }) async {
    try {
      Loader.openLoadingDialog(context: context);
      await googleSignIn.signOut();
      await firebaseAuth.signOut();

      await Future.delayed(
        const Duration(seconds: 2),
        () {
          getStorage.write(AppConfig.user, null);
          Loader.stopLoading(context: context);
        },
      );

      return right(unit);
    } on FirebaseAuthException catch (e) {
      Loader.stopLoading(context: context);
      return left(
        AuthFailure.serverError(
          message: e.toString(),
        ),
      );
    } on FirebaseException catch (e) {
      Loader.stopLoading(context: context);
      return left(
        AuthFailure.serverError(
          message: e.toString(),
        ),
      );
    } on PlatformException catch (e) {
      Loader.stopLoading(context: context);
      return left(
        AuthFailure.serverError(
          message: e.toString(),
        ),
      );
    } catch (e) {
      Loader.stopLoading(context: context);
      return left(
        AuthFailure.serverError(
          message: e.toString(),
        ),
      );
    }
  }
}
