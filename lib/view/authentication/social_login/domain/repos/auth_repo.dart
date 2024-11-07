import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:pet_app/view/authentication/social_login/domain/entities/user_entity.dart';
import 'package:pet_app/view/chat/errors/failures.dart';

abstract class AuthRepoo {


  Future<Either<Failure, UserEntityy>> signInWithGoogle(BuildContext context);

  Future<Either<Failure, UserEntityy>> signInWithFacebook();

  // Future<Either<Failure, UserEntityy>> signInWithApple();
}
