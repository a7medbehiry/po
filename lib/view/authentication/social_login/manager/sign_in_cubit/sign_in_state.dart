part of 'sign_in_cubit.dart';

@immutable
sealed class SignInnState {}

final class SignInnInitial extends SignInnState {}

final class SignInnLoading extends SignInnState {}

final class SignInnSuccess extends SignInnState {
  final UserEntityy userEntity;

  SignInnSuccess({required this.userEntity});
}

final class SignInnFailure extends SignInnState {
  final String message;

  SignInnFailure({required this.message});
}
