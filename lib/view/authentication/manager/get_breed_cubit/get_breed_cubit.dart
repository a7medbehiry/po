import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pet_app/model/get_breed_model.dart';
import 'package:pet_app/network/end_points.dart';
import 'package:pet_app/network/remote/dio_helper.dart';

part 'get_breed_state.dart';

class GetBreedCubit extends Cubit<GetBreedState> {
  GetBreedCubit() : super(GetBreedInitial());

  static GetBreedCubit get(context) => BlocProvider.of(context);

  GetBreedModel? getBreedModel;

  void userGetBreed() {
    emit(GetBreedLoading());
    DioHelper.getData(
      url: getBreed,
    ).then((value) {
      if (value != null) {
        print('data Register : ${jsonEncode(value.data)}');
        getBreedModel = GetBreedModel.fromJson(value.data);
        print('Parsed status: ${getBreedModel?.status}');
        print('Parsed message: ${getBreedModel?.message}');
        emit(
          GetBreedSuccess(getBreedModel: getBreedModel!),
        );
      } else {
        emit(GetBreedFailure(message: 'Null response received'));
      }
    }).catchError((error) {
      emit(GetBreedFailure(message: error.toString()));
    });
  }
}
