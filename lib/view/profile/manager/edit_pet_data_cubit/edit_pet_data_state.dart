part of 'edit_pet_data_cubit.dart';

@immutable
sealed class EditPetDataState {}

final class EditPetDataInitial extends EditPetDataState {}

final class EditPetNameInitial extends EditPetDataState {}

final class EditPetNameLoading extends EditPetDataState {}

final class EditPetNameSuccess extends EditPetDataState {
  final PetNameModel petNameModel;

  EditPetNameSuccess({required this.petNameModel});
}

final class EditPetNameFailure extends EditPetDataState {
  final String message;

  EditPetNameFailure({required this.message});
}

final class EditPetInfoInitial extends EditPetDataState {}

final class EditPetInfoLoading extends EditPetDataState {}

final class EditPetInfoSuccess extends EditPetDataState {
  final ChangeProfileInfoModel changeProfileInfoModel;

  EditPetInfoSuccess({required this.changeProfileInfoModel});
}

final class EditPetInfoFailure extends EditPetDataState {
  final String message;

  EditPetInfoFailure({required this.message});
}

final class EditPetPicInitial extends EditPetDataState {}

final class EditPetPicLoading extends EditPetDataState {}

final class EditPetPicSuccess extends EditPetDataState {
  final PetPicModel petPicModel;

  EditPetPicSuccess({required this.petPicModel});
}

final class EditPetPicFailure extends EditPetDataState {
  final String message;

  EditPetPicFailure({required this.message});
}
final class FirebaseEditPetPicInitial extends EditPetDataState {}

final class FirebaseEditPetPicLoading extends EditPetDataState {}

final class FirebaseEditPetPicSuccess extends EditPetDataState {
  final UserEntity userEntity;

  FirebaseEditPetPicSuccess({required this.userEntity});
}

final class FirebaseEditPetPicFailure extends EditPetDataState {
  final String message;

  FirebaseEditPetPicFailure({required this.message});
}
