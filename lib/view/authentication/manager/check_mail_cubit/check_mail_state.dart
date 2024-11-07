part of 'check_mail_cubit.dart';

@immutable
sealed class CheckMailState {}

final class CheckMailInitial extends CheckMailState {}

final class CheckMailLoading extends CheckMailState {}

final class CheckMailSuccess extends CheckMailState {
  final CheckMailModel checkMailModel;

  CheckMailSuccess({required this.checkMailModel});
}

final class CheckMailFailure extends CheckMailState {
  final String message;

  CheckMailFailure({required this.message});
}
