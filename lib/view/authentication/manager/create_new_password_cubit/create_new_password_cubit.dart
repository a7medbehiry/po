import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pet_app/network/end_points.dart';
import 'package:pet_app/network/remote/dio_helper.dart';
import 'package:pet_app/view/authentication/data/models/create_new_password_model.dart';

part 'create_new_password_state.dart';

class CreateNewPasswordCubit extends Cubit<CreateNewPasswordState> {
  CreateNewPasswordCubit() : super(CreateNewPasswordInitial());

  static CreateNewPasswordCubit get(context) => BlocProvider.of(context);

  CreateNewPasswordModel? createNewPasswordModel;

  void userCreateNewPassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(CreateNewPasswordLoading());

    DioHelper.postData(
      url: createNewPassword,
      data: {
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
      },
    ).then((value) {
      if (value != null) {
        print('data Register : ${jsonEncode(value.data)}');
        createNewPasswordModel = CreateNewPasswordModel.fromJson(value.data);
        print('Parsed status: ${createNewPasswordModel?.status}');
        print('Parsed message: ${createNewPasswordModel?.message}');
        emit(
          CreateNewPasswordSuccess(
              createNewPasswordModel: createNewPasswordModel!),
        );
      } else {
        emit(CreateNewPasswordFailure(message: 'Null response received'));
      }
    }).catchError((error) {
      print(error.toString());
      emit(CreateNewPasswordFailure(message: error.toString()));
    });
  }
}
