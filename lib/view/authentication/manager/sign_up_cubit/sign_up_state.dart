part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class SignUpSuccess extends SignUpState {
  final SignUpModel signUpModel;

  SignUpSuccess({required this.signUpModel});
}

final class SignUpFailure extends SignUpState {
  final String message;

  SignUpFailure({required this.message});
}

final class AddPetInitial extends SignUpState {}

final class AddPetLoading extends SignUpState {}

final class AddPetSuccess extends SignUpState {
  final AddPetModel addPetModel;

  AddPetSuccess({required this.addPetModel});
}

final class AddPetFailure extends SignUpState {
  final String message;

  AddPetFailure({required this.message});
}
