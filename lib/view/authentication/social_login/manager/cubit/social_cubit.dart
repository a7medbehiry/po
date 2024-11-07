import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pet_app/components/constant.dart';
import 'package:pet_app/network/end_points.dart';
import 'package:pet_app/network/local/cache_helper.dart';
import 'package:pet_app/network/remote/dio_helper.dart';
import 'package:pet_app/view/authentication/social_login/data/models/social_model.dart';

part 'social_state.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitial());

  SocialModel? socialModel;

  void social({
    required String? name,
    required String? email,
  }) {
    emit(SocialLoading());
    DioHelper.postData(
      url: login,
      data: {
        "name": name,
        "email": email,
        "joined_with": 2,
      },
    ).then((value) {
      if (value != null) {
        socialModel = SocialModel.fromJson(value.data);
        userToken =
            CacheHelper.saveData(key: 'token', value: socialModel?.data?.token);
        emit(SocialSuccess(socialModel: socialModel!));
      } else {
        emit(
          SocialFailure(message: 'Null response received'),
        );
      }
    }).catchError((error) {
      emit(SocialFailure(message: error.toString()));
    });
  }
}
