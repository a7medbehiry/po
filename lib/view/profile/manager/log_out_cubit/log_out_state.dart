part of 'log_out_cubit.dart';

@immutable
sealed class LogOutState {}

final class LogOutInitial extends LogOutState {}

final class LogOutLoading extends LogOutState {}

final class LogOutSuccess extends LogOutState {
  final LogOutModel logOutModel;

  LogOutSuccess({required this.logOutModel});
}

final class LogOutFailure extends LogOutState {
  final String message;

  LogOutFailure({required this.message});
}
