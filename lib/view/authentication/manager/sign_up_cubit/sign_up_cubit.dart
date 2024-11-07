import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pet_app/network/local/cache_helper.dart';
import 'package:pet_app/view/authentication/data/models/sign_up_model.dart';
import 'package:pet_app/network/end_points.dart';
import 'package:pet_app/network/remote/dio_helper.dart';
import 'package:pet_app/view/profile/data/models/pet_profile_models/add_pet_model.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  static SignUpCubit get(context) => BlocProvider.of(context);

  SignUpModel? signUpModel;
  AddPetModel? addPetModel;

  void userSignUp({
     String? firstName,
     String ?lastName,
     String ?email,
     String ?phone,
     String ?address,
     String ?password,
     String ?confirmPassword,
     String ?name,
     String ?age,
     String ?type,
     String ?gender,
     String ?breed,
     int ?join,
  }) {
    emit(SignUpLoading());
    DioHelper.postData(
      url: signUp,
      data: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone': phone,
        'address': address,
        'password': password,
        'password_confirmation': confirmPassword,
        'name': name,
        'age': age,
        'type': type,
        'gender': gender,
        'breed': breed,
        'joined_with': join,
      },
    ).then((value) {
      if (value != null) {
        signUpModel = SignUpModel.fromJson(value.data);
        print('Parsed status: ${signUpModel?.status}');
        print('Parsed token: ${signUpModel?.data?.token}');
        print('Parsed message: ${signUpModel?.message}');

        emit(SignUpSuccess(signUpModel: signUpModel!));
      } else {
        emit(
          SignUpFailure(message: 'Null response received'),
        );
      }
    }).catchError((error) {
      emit(SignUpFailure(message: error.toString()));
    });
  }

  void userAddPet({
    required String name,
    required String age,
    required String type,
    required String gender,
    required String breed,
    required File pic,
  }) async {
    emit(SignUpLoading());

    Map<String, dynamic> formDataMap = {
      'name': name,
      'age': age,
      'type': type,
      'gender': gender,
      'breed': breed,
    };

    formDataMap['picture'] = await MultipartFile.fromFile(
      pic.path,
      filename: pic.path.split('/').last,
    );

    FormData formData = FormData.fromMap(formDataMap);

    DioHelper.postImageData(
      url: addPet,
      data: formData,
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      if (value != null) {
        addPetModel = AddPetModel.fromJson(value.data);
        print('Parsed status: ${addPetModel?.status}');
        print('Parsed message: ${addPetModel?.message}');
        print('Parsed id: ${addPetModel?.data?.pet?.id}');
        emit(AddPetSuccess(addPetModel: addPetModel!));
      } else {
        emit(
          AddPetFailure(message: 'Null response received'),
        );
      }
    }).catchError((error) {
      emit(AddPetFailure(message: error.toString()));
    });
  }
}
