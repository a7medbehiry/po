import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';
import 'package:pet_app/view/authentication/social_login/domain/entities/user_entity.dart';
import 'package:pet_app/view/authentication/social_login/domain/repos/auth_repo.dart';

part 'sign_in_state.dart';

class SignInnCubit extends Cubit<SignInnState> {
  SignInnCubit(this.authRepo) : super(SignInnInitial());
  final AuthRepoo authRepo;



  Future<void> signInWithGoogle(BuildContext context) async {
    emit(SignInnLoading());
    final result = await authRepo.signInWithGoogle(context);
    result.fold(
      (failure) => emit(SignInnFailure(message: failure.message)),
      (userEntity) => emit(SignInnSuccess(userEntity: userEntity)),
    );
  }

  // user/register-social
  

  Future<void> signInWithFacebook() async {
    emit(SignInnLoading());
    final result = await authRepo.signInWithFacebook();
    result.fold(
      (failure) => emit(SignInnFailure(message: failure.message)),
      (userEntity) => emit(SignInnSuccess(userEntity: userEntity)),
    );
  }


  // Future<void> signInWithApple() async {
  //   emit(SignInnLoading());
  //   final result = await authRepo.signInWithApple ();
  //   result.fold(
  //     (failure) => emit(SignInnFailure(message: failure.message)),
  //     (userEntity) => emit(SignInnSuccess(userEntity: userEntity)),
  //   );
  // }
}
