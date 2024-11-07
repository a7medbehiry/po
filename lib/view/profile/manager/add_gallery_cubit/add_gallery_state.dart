part of 'add_gallery_cubit.dart';

@immutable
sealed class AddGalleryState {}

final class AddGalleryInitial extends AddGalleryState {}

final class AddGalleryLoading extends AddGalleryState {}

final class AddGallerySuccess extends AddGalleryState {
  final AddGalleryModel addGalleryModel;

  AddGallerySuccess({required this.addGalleryModel});
}

final class AddGalleryFailure extends AddGalleryState {
  final String message;

  AddGalleryFailure({required this.message});
}
