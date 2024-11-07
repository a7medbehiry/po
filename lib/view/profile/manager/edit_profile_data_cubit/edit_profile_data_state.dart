part of 'edit_profile_data_cubit.dart';

@immutable
sealed class EditProfileDataState {}

final class EditProfileDataInitial extends EditProfileDataState {}

final class EditProfileDataLoading extends EditProfileDataState {}

final class EditProfileDataSuccess extends EditProfileDataState {
  final ChangeProfileDataModel changeProfileDataModel;

  EditProfileDataSuccess({
    required this.changeProfileDataModel,
  });
}

final class EditProfileDataFailure extends EditProfileDataState {
  final String message;

  EditProfileDataFailure({required this.message});
}

final class ChangePasswordInitial extends EditProfileDataState {}

final class ChangePasswordLoading extends EditProfileDataState {}

final class ChangePasswordSuccess extends EditProfileDataState {
  final ChangePasswordModel changePasswordModel;

  ChangePasswordSuccess({required this.changePasswordModel});
}

final class ChangePasswordFailure extends EditProfileDataState {
  final String message;

  ChangePasswordFailure({required this.message});
}

final class ChangeAddressInitial extends EditProfileDataState {}

final class ChangeAddressLoading extends EditProfileDataState {}

final class ChangeAddressSuccess extends EditProfileDataState {
  final ChangeAddressModel changeAddressModel;

  ChangeAddressSuccess({required this.changeAddressModel});
}

final class ChangeAddressFailure extends EditProfileDataState {
  final String message;

  ChangeAddressFailure({required this.message});
}

final class UploadProfilePicInitial extends EditProfileDataState {}

final class UploadProfilePicLoading extends EditProfileDataState {}

final class UploadProfilePicSuccess extends EditProfileDataState {
  final UploadProfilePicModel uploadProfilePicModel;

  UploadProfilePicSuccess({required this.uploadProfilePicModel});
}

final class UploadProfilePicFailure extends EditProfileDataState {
  final String message;

  UploadProfilePicFailure({required this.message});
}
