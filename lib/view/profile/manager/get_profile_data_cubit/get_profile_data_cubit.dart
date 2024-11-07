import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pet_app/network/end_points.dart';
import 'package:pet_app/network/local/cache_helper.dart';
import 'package:pet_app/network/remote/dio_helper.dart';
import 'package:pet_app/view/profile/data/models/user_profile_models/profile_get_data_model/profile_get_data_model.dart';

part 'get_profile_data_state.dart';

class GetProfileDataCubit extends Cubit<GetProfileDataState> {
  GetProfileDataCubit() : super(GetProfileDataInitial());

  static GetProfileDataCubit get(context) => BlocProvider.of(context);
  ProfileGetDataModel? profileGetDataModel;

  void userGetProfileData() {
    emit(GetProfileDataLoading());
    DioHelper.getData(
      url: getProfileData,
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      if (value != null) {
        print('data Register : ${jsonEncode(value.data)}');
        profileGetDataModel = ProfileGetDataModel.fromJson(value.data);
        print('Parsed status: ${profileGetDataModel?.status}');
        print('Parsed message: ${profileGetDataModel?.message}');
        emit(
          GetProfileDataSuccess(profileGetDataModel: profileGetDataModel!),
        );
      } else {
        emit(GetProfileDataFailure(message: 'Null response received'));
      }
    }).catchError((error) {
      emit(GetProfileDataFailure(message: error.toString()));
    });
  }
}
