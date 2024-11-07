import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pet_app/network/end_points.dart';
import 'package:pet_app/network/local/cache_helper.dart';
import 'package:pet_app/network/remote/dio_helper.dart';
import 'package:pet_app/view/profile/data/models/user_profile_models/chane_profile_date_model.dart';
import 'package:pet_app/view/profile/data/models/user_profile_models/change_address_model.dart';
import 'package:pet_app/view/profile/data/models/user_profile_models/change_password_model.dart';
import 'package:pet_app/view/profile/data/models/user_profile_models/upload_profile_pic_model.dart';

part 'edit_profile_data_state.dart';

class EditProfileDataCubit extends Cubit<EditProfileDataState> {
  EditProfileDataCubit() : super(EditProfileDataInitial());
  static EditProfileDataCubit get(context) => BlocProvider.of(context);

  UploadProfilePicModel? uploadProfilePicModel;
  ChangeProfileDataModel? changeProfileDataModel;
  ChangePasswordModel? changePasswordModel;
  ChangeAddressModel? changeAddressModel;

  void uploadProfilePic({
    required File? pic,
  }) async {
    emit(UploadProfilePicLoading());

    DioHelper.postImageData(
      url: changeProfileData,
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
        uploadProfilePicModel = UploadProfilePicModel.fromJson(value.data);
        print('Parsed status: ${uploadProfilePicModel?.status}');
        print('Parsed message: ${uploadProfilePicModel?.message}');
        emit(UploadProfilePicSuccess(
            uploadProfilePicModel: uploadProfilePicModel!));
      } else {
        emit(
          UploadProfilePicFailure(message: 'Null response received'),
        );
      }
    }).catchError((error) {
      emit(UploadProfilePicFailure(message: error.toString()));
    });
  }

  void changeUserName({
    required String firstName,
    required String lastName,
  }) {
    emit(EditProfileDataLoading());
    DioHelper.postData(
      url: changeProfileData,
      data: {
        'first_name': firstName,
        'last_name': lastName,
      },
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      if (value != null) {
        changeProfileDataModel = ChangeProfileDataModel.fromJson(value.data);
        print('Parsed status: ${changeProfileDataModel?.status}');
        print('Parsed message: ${changeProfileDataModel?.message}');
        emit(EditProfileDataSuccess(
            changeProfileDataModel: changeProfileDataModel!));
      } else {
        emit(
          EditProfileDataFailure(message: 'Null response received'),
        );
      }
    }).catchError((error) {
      emit(EditProfileDataFailure(message: error.toString()));
    });
  }

  void userChangePassword({
    required String oldPassword,
    required String password,
    required String confirmPassword,
  }) {
    emit(ChangePasswordLoading());
    DioHelper.postData(
      url: changePassword,
      data: {
        'old_password': oldPassword,
        'password': password,
        'password_confirmation': confirmPassword,
      },
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      if (value != null) {
        changePasswordModel = ChangePasswordModel.fromJson(value.data);
        print('Parsed status: ${changePasswordModel?.status}');
        print('Parsed message: ${changePasswordModel?.message}');
        emit(ChangePasswordSuccess(changePasswordModel: changePasswordModel!));
      } else {
        emit(
          ChangePasswordFailure(message: 'Null response received'),
        );
      }
    }).catchError((error) {
      emit(ChangePasswordFailure(message: error.toString()));
    });
  }

  void userChangeAddress({
    required String address,
  }) {
    emit(ChangeAddressLoading());
    DioHelper.postData(
      url: changeProfileData,
      data: {
        'address': address,
      },
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      if (value != null) {
        changeAddressModel = ChangeAddressModel.fromJson(value.data);
        print('Parsed status: ${changeAddressModel?.status}');
        print('Parsed message: ${changeAddressModel?.message}');
        emit(ChangeAddressSuccess(changeAddressModel: changeAddressModel!));
      } else {
        emit(
          ChangeAddressFailure(message: 'Null response received'),
        );
      }
    }).catchError((error) {
      emit(ChangeAddressFailure(message: error.toString()));
    });
  }
}
