import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pet_app/network/end_points.dart';
import 'package:pet_app/network/local/cache_helper.dart';
import 'package:pet_app/network/remote/dio_helper.dart';
import 'package:pet_app/view/profile/data/models/user_profile_models/log_out_model.dart';

part 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit() : super(LogOutInitial());

  static LogOutCubit get(context) => BlocProvider.of(context);
  LogOutModel? logOutModel;
  void userLogout() {
    emit(LogOutLoading());
    DioHelper.getData(
      url: logOut,
      token: CacheHelper.getData(
        key: 'token',
      ),
    ).then((value) {
      if (value != null) {
        print('data Register : ${jsonEncode(value.data)}');
        logOutModel = LogOutModel.fromJson(value.data);
        print('Parsed status: ${logOutModel?.status}');
        print('Parsed message: ${logOutModel?.message}');
        emit(
          LogOutSuccess(logOutModel: logOutModel!),
        );
      } else {
        emit(LogOutFailure(message: 'Null response received'));
      }
    }).catchError((error) {
      print(error.toString());
      emit(LogOutFailure(message: error.toString()));
    });
  }
}
