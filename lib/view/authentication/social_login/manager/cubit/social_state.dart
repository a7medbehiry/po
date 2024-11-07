part of 'social_cubit.dart';

@immutable
sealed class SocialState {}

final class SocialInitial extends SocialState {}

final class SocialLoading extends SocialState {}

final class SocialSuccess extends SocialState {
  final SocialModel socialModel;

  SocialSuccess({required this.socialModel});
}

final class SocialFailure extends SocialState {
  final String message;

  SocialFailure({required this.message});
}
