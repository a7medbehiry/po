part of 'get_all_clinics_cubit.dart';

@immutable
sealed class GetAllClinicsState {}

final class GetAllClinicsInitial extends GetAllClinicsState {}

final class GetAllClinicsLoading extends GetAllClinicsState {}

final class GetAllClinicsSuccess extends GetAllClinicsState {
  final GetAllClinicsModel getAllClinicsModel;

  GetAllClinicsSuccess({required this.getAllClinicsModel});
}

final class GetAllClinicsFailure extends GetAllClinicsState {
  final String message;

  GetAllClinicsFailure({required this.message});
}
