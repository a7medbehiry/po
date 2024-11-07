part of 'get_breed_cubit.dart';

@immutable
sealed class GetBreedState {}

final class GetBreedInitial extends GetBreedState {}

final class GetBreedLoading extends GetBreedState {}

final class GetBreedSuccess extends GetBreedState {
  final GetBreedModel getBreedModel;

  GetBreedSuccess({required this.getBreedModel});
}

final class GetBreedFailure extends GetBreedState {
  final String message;

  GetBreedFailure({required this.message});
}
