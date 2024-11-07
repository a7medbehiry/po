import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pet_app/network/end_points.dart';
import 'package:pet_app/network/local/cache_helper.dart';
import 'package:pet_app/network/remote/dio_helper.dart';
import 'package:pet_app/view/profile/data/models/help_and_support_model.dart';

part 'help_and_support_state.dart';

class HelpAndSupportCubit extends Cubit<HelpAndSupportState> {
  HelpAndSupportCubit() : super(HelpAndSupportInitial());

  static HelpAndSupportCubit get(context) => BlocProvider.of(context);

  HelpAndSupportModel? helpAndSupportModel;


  void userHelpAndSupport({
    required String message,
  
  }) {
    emit(HelpAndSupportLoading());
    DioHelper.postData(
      url: helpAndSupport,
      data: {
        'message': message,
      },
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      if (value != null) {
        print('data Register : ${jsonEncode(value.data)}');

        helpAndSupportModel = HelpAndSupportModel.fromJson(value.data);
        print('Parsed status: ${helpAndSupportModel?.status}');
        print('Parsed message: ${helpAndSupportModel?.message}');

        emit(HelpAndSupportSuccess(helpAndSupportModel: helpAndSupportModel!));
      } else {
        emit(HelpAndSupportFailure(message: 'Null response received'));
      }
    }).catchError((error) {
      print(error.toString());
      emit(HelpAndSupportFailure(message: error.toString()));
    });
  }
}
