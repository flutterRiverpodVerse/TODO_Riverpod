import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:todo_riverpod/features/auth/domain/auth_failure.dart';

abstract class AbAuthRemoteServices {
  Future<Either<AuthFailure, Unit>> signInWithGoogle({
    required BuildContext context,
  });

  Future<bool> isUserLoggedIn();

  Future<Either<AuthFailure, Unit>> logout({
    required BuildContext context,
  });
}
