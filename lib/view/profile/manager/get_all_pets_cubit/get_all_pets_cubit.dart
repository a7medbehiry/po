import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pet_app/network/end_points.dart';
import 'package:pet_app/network/local/cache_helper.dart';
import 'package:pet_app/network/remote/dio_helper.dart';
import 'package:pet_app/view/profile/data/models/get_all_pets_model/get_all_pets_model.dart';

part 'get_all_pets_state.dart';

class GetAllPetsCubit extends Cubit<GetAllPetsState> {
  GetAllPetsCubit() : super(GetAllPetsInitial());

  static GetAllPetsCubit get(context) => BlocProvider.of(context);

  GetAllPetsModel? getAllPetsModel;

  void getAllPetsData() {
    emit(GetAllPetsLoading());
    DioHelper.getData(
      url: getAllPets,
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      if (value != null) {
        print('data Register : ${jsonEncode(value.data)}');
        getAllPetsModel = GetAllPetsModel.fromJson(value.data);
        print('Parsed status: ${getAllPetsModel?.status}');
        print('Parsed message: ${getAllPetsModel?.message}');

        emit(
          GetAllPetsSuccess(getAllPetsModel: getAllPetsModel!),
        );
      } else {
        emit(GetAllPetsFailure(message: 'Null response received'));
      }
    }).catchError((error) {
      emit(GetAllPetsFailure(message: error.toString()));
    });
  }
}
