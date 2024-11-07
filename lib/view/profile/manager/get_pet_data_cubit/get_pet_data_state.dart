part of 'get_pet_data_cubit.dart';

@immutable
sealed class GetPetDataState {}

final class GetPetDataInitial extends GetPetDataState {}

final class GetPetDataLoading extends GetPetDataState {}

final class GetPetDataSuccess extends GetPetDataState {
  final GetPetModel getPetModel;

  GetPetDataSuccess({required this.getPetModel});
}

final class GetPetDataFailure extends GetPetDataState {
  final String message;

  GetPetDataFailure({required this.message});
}
