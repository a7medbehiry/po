import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pet_app/network/end_points.dart';
import 'package:pet_app/network/remote/dio_helper.dart';
import 'package:pet_app/view/authentication/data/models/check_mail_model.dart';

part 'check_mail_state.dart';

class CheckMailCubit extends Cubit<CheckMailState> {
  CheckMailCubit() : super(CheckMailInitial());

  static CheckMailCubit get(context) => BlocProvider.of(context);
  CheckMailModel? checkMailModel;

  void userCheckMail({
    required String email,
    required String otp,
  }) {
    emit(CheckMailLoading());
    DioHelper.postData(
      url: checkMail,
      data: {
        'email': email,
        'code': otp,
      },
    ).then((value) {
      if (value != null) {
        print('data Register : ${jsonEncode(value.data)}');

        checkMailModel = CheckMailModel.fromJson(value.data);
        print('Parsed status: ${checkMailModel?.status}');
        print('Parsed message: ${checkMailModel?.message}');

        emit(CheckMailSuccess(checkMailModel: checkMailModel!));
      } else {
        emit(CheckMailFailure(message: 'Null response received'));
      }
    }).catchError((error) {
      print(error.toString());
      emit(CheckMailFailure(message: error.toString()));
    });
  }
}
