import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pet_app/network/local/cache_helper.dart';
import 'package:pet_app/network/remote/dio_helper.dart';
import 'package:pet_app/view/profile/data/models/pet_profile_models/get_pet_model/get_pet_model.dart';

part 'get_pet_data_state.dart';

class GetPetDataCubit extends Cubit<GetPetDataState> {
  GetPetDataCubit() : super(GetPetDataInitial());

  static GetPetDataCubit get(context) => BlocProvider.of(context);

  GetPetModel? getPetModel;

  void userGetPetData({int? id}) {
    emit(GetPetDataLoading());
    DioHelper.getData(
      url: 'https://pet-app.webbing-agency.com/api/user/$id',
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      if (value != null) {
        print('data Register : ${jsonEncode(value.data)}');
        getPetModel = GetPetModel.fromJson(value.data);
        print('Parsed status: ${getPetModel?.status}');
        print('Parsed message: ${getPetModel?.message}');
      

        emit(
          GetPetDataSuccess(getPetModel: getPetModel!),
        );
      } else {
        emit(GetPetDataFailure(message: 'Null response received'));
      }
    }).catchError((error) {
      emit(GetPetDataFailure(message: error.toString()));
    });
  }
}
