part of 'create_new_password_cubit.dart';

@immutable
sealed class CreateNewPasswordState {}

final class CreateNewPasswordInitial extends CreateNewPasswordState {}

final class CreateNewPasswordLoading extends CreateNewPasswordState {}

final class CreateNewPasswordSuccess extends CreateNewPasswordState {
  final CreateNewPasswordModel createNewPasswordModel;

  CreateNewPasswordSuccess({required this.createNewPasswordModel});
}

final class CreateNewPasswordFailure extends CreateNewPasswordState {
  final String message;

  CreateNewPasswordFailure({required this.message});
}
