import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pet_app/network/end_points.dart';
import 'package:pet_app/network/remote/dio_helper.dart';
import 'package:pet_app/view/authentication/data/models/forget_password_model.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  static ForgetPasswordCubit get(context) => BlocProvider.of(context);
  ForgetPasswordModel? forgetPasswordModel;

  void userForgetPassword({
    required String email,
  }) {
    emit(ForgetPasswordLoading());

    DioHelper.getData(
      url: forgetPassword,
      data: {
        'email': email,
      },
    ).then((value) {
      if (value != null) {
        print('data Register : ${jsonEncode(value.data)}');
        forgetPasswordModel = ForgetPasswordModel.fromJson(value.data);
        print('Parsed status: ${forgetPasswordModel?.status}');
        print('Parsed message: ${forgetPasswordModel?.message}');
        emit(
          ForgetPasswordSuccess(forgetPasswordModel: forgetPasswordModel!),
        );
      } else {
        emit(ForgetPasswordFailure(message: 'Null response received'));
      }
    }).catchError((error) {
      print(error.toString());
      emit(ForgetPasswordFailure(message: error.toString()));
    });
  }
}
