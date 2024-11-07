part of 'help_and_support_cubit.dart';

@immutable
sealed class HelpAndSupportState {}

final class HelpAndSupportInitial extends HelpAndSupportState {}
final class HelpAndSupportLoading extends HelpAndSupportState {}
final class HelpAndSupportSuccess extends HelpAndSupportState {
  final HelpAndSupportModel helpAndSupportModel;
  HelpAndSupportSuccess({required this.helpAndSupportModel});
}
final class HelpAndSupportFailure extends HelpAndSupportState {
  final String message;
  HelpAndSupportFailure({required this.message});
}
