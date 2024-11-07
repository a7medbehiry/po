import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pet_app/network/end_points.dart';
import 'package:pet_app/network/local/cache_helper.dart';
import 'package:pet_app/network/remote/dio_helper.dart';
import 'package:pet_app/view/clinics/data/models/get_all_clinics/get_all_clinics.dart';

part 'get_all_clinics_state.dart';

class GetAllClinicsCubit extends Cubit<GetAllClinicsState> {
  GetAllClinicsCubit() : super(GetAllClinicsInitial());

  static GetAllClinicsCubit get(context) => BlocProvider.of(context);

  GetAllClinicsModel? getAllClinicsModel;

  void getAllClinicsFunction() {
    emit(GetAllClinicsLoading());
    DioHelper.getData(
      url: getAllClinics,
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      if (value != null) {
        getAllClinicsModel = GetAllClinicsModel.fromJson(value.data);
        emit(GetAllClinicsSuccess(getAllClinicsModel: getAllClinicsModel!));
      } else {
        emit(GetAllClinicsFailure(message: 'Null response received'));
      }
    }).catchError((error) {
      emit(GetAllClinicsFailure(message: error.toString()));
    });
  }
}
