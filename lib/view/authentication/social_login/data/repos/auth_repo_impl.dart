import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/view/authentication/social_login/data/firebase_auth_service.dart';
import 'package:pet_app/view/authentication/social_login/data/models/user_mode.dart';
import 'package:pet_app/view/authentication/social_login/domain/entities/user_entity.dart';
import 'package:pet_app/view/authentication/social_login/domain/repos/auth_repo.dart';
import 'package:pet_app/view/chat/errors/failures.dart';

class AuthRepoImpl extends AuthRepoo {
  final FirebaseAuthServicee firebaseAuthService;

  AuthRepoImpl({required this.firebaseAuthService});

  @override
  Future<Either<Failure, UserEntityy>> signInWithGoogle(BuildContext context) async {
    try {
      User user = await firebaseAuthService.signInWithGoogle(context);
      return right(UserModell.fromFirebaseUser(user));
    } catch (e) {
      log('Exception in AuthRepoImpl.signInWithGoogle: $e');
      return left(
        ServerFailure('لقد حدث خطأ ما. الرجاء المحاولة مرة اخري.'),
      );
    }
  }

  @override
  Future<Either<Failure, UserEntityy>> signInWithFacebook() async {
    try {
      User user = await firebaseAuthService.signInWithFacebook();
      return right(UserModell.fromFirebaseUser(user));
    } catch (e) {
      log('Exception in AuthRepoImpl.signInWithFacebook: $e');
      return left(
        ServerFailure('لقد حدث خطأ ما. الرجاء المحاولة مرة اخري.'),
      );
    }
  }

  // @override
  // Future<Either<Failure, UserEntityy>> signInWithApple() async {
  //   try {
  //     var user = await firebaseAuthService.signInWithApple();
  //     return right(UserModell.fromFirebaseUser(user));
  //   } catch (e) {
  //     log('Exception in AuthRepoImpl.signInWithApple: $e');
  //     return left(
  //       ServerFailure('لقد حدث خطأ ما. الرجاء المحاولة مرة اخ'),
  //     );
  //   }
  // }
}
