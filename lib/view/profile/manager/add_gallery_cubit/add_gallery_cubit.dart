import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pet_app/network/local/cache_helper.dart';
import 'package:pet_app/network/remote/dio_helper.dart';
import 'package:pet_app/view/profile/data/models/add_gallery_model/add_gallery_model.dart';

part 'add_gallery_state.dart';

class AddGalleryCubit extends Cubit<AddGalleryState> {
  AddGalleryCubit() : super(AddGalleryInitial());

  static AddGalleryCubit get(context) => BlocProvider.of(context);
  AddGalleryModel? addGalleryModel;

  void uploadGalleryPic({
    required File pic,
    required int id,
  }) async {
    emit(AddGalleryLoading());

    try {
      // Create FormData
      FormData formData = FormData.fromMap({
        'images[]': await MultipartFile.fromFile(
          pic.path,
          filename: pic.path.split('/').last,
        ),
      });

      // Make the POST request
      final response = await DioHelper.postImageData(
        url: 'https://pet-app.webbing-agency.com/api/user/$id/add-image',
        data: formData,
        token: CacheHelper.getData(key: 'token'),
      );

      // Handle the response
      if (response != null) {
        addGalleryModel = AddGalleryModel.fromJson(response.data);
        emit(AddGallerySuccess(addGalleryModel: addGalleryModel!));
      } else {
        emit(AddGalleryFailure(message: 'Null response received'));
      }
    } catch (error) {
      emit(AddGalleryFailure(message: error.toString()));
    }
  }
}
