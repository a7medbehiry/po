part of 'get_all_pets_cubit.dart';

@immutable
sealed class GetAllPetsState {}

final class GetAllPetsInitial extends GetAllPetsState {}

final class GetAllPetsLoading extends GetAllPetsState {}

final class GetAllPetsSuccess extends GetAllPetsState {
  final GetAllPetsModel getAllPetsModel;
  GetAllPetsSuccess({required this.getAllPetsModel});
}

final class GetAllPetsFailure extends GetAllPetsState {
  final String message;

  GetAllPetsFailure({required this.message});
}
