part of 'get_profile_data_cubit.dart';

@immutable
sealed class GetProfileDataState {}

final class GetProfileDataInitial extends GetProfileDataState {}

final class GetProfileDataLoading extends GetProfileDataState {}

final class GetProfileDataSuccess extends GetProfileDataState {
  final ProfileGetDataModel profileGetDataModel;

  GetProfileDataSuccess({required this.profileGetDataModel});
}

final class GetProfileDataFailure extends GetProfileDataState {
  final String message;

  GetProfileDataFailure({required this.message});
}
