import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pet_app/network/end_points.dart';
import 'package:pet_app/network/remote/dio_helper.dart';

import '../../data/models/sign_in_model.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  static SignInCubit get(context) => BlocProvider.of(context);
  SignInModel? signInModel;

  void userSignIn({
    required String? email,
    required String password,
  }) {
    emit(SignInLoading());
    DioHelper.postData(
      url: signIn,
      data: {
        "email": email,
        "password": password,
      },
    ).then((value) {
      if (value != null) {
        signInModel = SignInModel.fromJson(value.data);
        print('Parsed status: ${signInModel?.status}');
        print('Parsed token: ${signInModel?.data?.token}');
        print('Parsed message: ${signInModel?.message}');
        emit(SignInSuccess(signInModel: signInModel!));
      } else {
        emit(
          SignInFailure(message: 'Null response received'),
        );
      }
    }).catchError((error) {
      emit(SignInFailure(message: error.toString()));
    });
  }
}
