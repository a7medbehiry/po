import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pet_app/network/local/cache_helper.dart';
import 'package:pet_app/network/remote/dio_helper.dart';
import 'package:pet_app/view/chat/domain/entities/user_entity.dart';
import 'package:pet_app/view/profile/data/models/pet_profile_models/edit_name_model.dart';
import 'package:pet_app/view/profile/data/models/pet_profile_models/edit_pet_info.dart';
import 'package:pet_app/view/profile/data/models/pet_profile_models/picture_model.dart';


part 'edit_pet_data_state.dart';

class EditPetDataCubit extends Cubit<EditPetDataState> {
  EditPetDataCubit(
  ) : super(EditPetDataInitial());

  static EditPetDataCubit get(context) => BlocProvider.of(context);

  PetPicModel? petPicModel;
  PetNameModel? petNameModel;
  ChangeProfileInfoModel? changeProfileInfoModel;



  void uploadPetPic({
    required File? pic,
    int? id,
  }) async {
    emit(EditPetPicLoading());
    DioHelper.postImageData(
      url: 'https://pet-app.webbing-agency.com/api/user/$id/update',
      data: FormData.fromMap(
        {
          "picture": [
            await MultipartFile.fromFile(
              pic!.path,
              filename: pic.path.split('/').last,
            ),
          ],
        },
      ),
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      if (value != null) {
        petPicModel = PetPicModel.fromJson(value.data);
        print('Parsed status: ${petPicModel?.status}');
        print('Parsed message: ${petPicModel?.message}');
        emit(EditPetPicSuccess(petPicModel: petPicModel!));
      } else {
        emit(
          EditPetPicFailure(message: 'Null response received'),
        );
      }
    }).catchError((error) {
      emit(EditPetPicFailure(message: error.toString()));
    });
  }

  void changePetName({
    required String name,
    int? id,
  }) {
    emit(EditPetNameLoading());
    DioHelper.postData(
      url: 'https://pet-app.webbing-agency.com/api/user/$id/update',
      data: {
        'name': name,
      },
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      if (value != null) {
        petNameModel = PetNameModel.fromJson(value.data);
        print('Parsed status: ${petNameModel?.status}');
        print('Parsed message: ${petNameModel?.message}');
        emit(EditPetNameSuccess(petNameModel: petNameModel!));
      } else {
        emit(
          EditPetNameFailure(message: 'Null response received'),
        );
      }
    }).catchError((error) {
      emit(EditPetNameFailure(message: error.toString()));
    });
  }

  void changePetInfo({
    String? age,
    String? gender,
    String? type,
    String? breed,
    int? id,
  }) {
    emit(EditPetInfoLoading());
    DioHelper.postData(
      url: 'https://pet-app.webbing-agency.com/api/user/$id/update',
      data: {
        'age': age,
        'gender': gender,
        'type': type,
        'breed': breed,
      },
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      if (value != null) {
        changeProfileInfoModel = ChangeProfileInfoModel.fromJson(value.data);
        print('Parsed status: ${changeProfileInfoModel?.status}');
        print('Parsed message: ${changeProfileInfoModel?.message}');
        emit(EditPetInfoSuccess(
            changeProfileInfoModel: changeProfileInfoModel!));
      } else {
        emit(
          EditPetInfoFailure(message: 'Null response received'),
        );
      }
    }).catchError((error) {
      emit(EditPetInfoFailure(message: error.toString()));
    });
  }
}
