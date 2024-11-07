part of 'forget_password_cubit.dart';

@immutable
sealed class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class ForgetPasswordLoading extends ForgetPasswordState {}

final class ForgetPasswordSuccess extends ForgetPasswordState {
  final ForgetPasswordModel forgetPasswordModel;

  ForgetPasswordSuccess({required this.forgetPasswordModel});
}

final class ForgetPasswordFailure extends ForgetPasswordState {
  final String message;

  ForgetPasswordFailure({required this.message});
}
