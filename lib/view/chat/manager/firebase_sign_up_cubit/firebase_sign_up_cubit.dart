import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pet_app/view/chat/domain/entities/user_entity.dart';
import 'package:pet_app/view/chat/domain/repos/auth_repo.dart';

part 'firebase_sign_up_state.dart';

class FirebaseSignUpCubit extends Cubit<FirebaseSignUpState> {
  FirebaseSignUpCubit(this.authRepo) : super(FirebaseSignUpInitial());

  final AuthRepo authRepo;

  Future<void> createUserWithEmailAndPassword(
      String name, String email, String password) async {
    emit(FirebaseSignUpLoading());
    final result = await authRepo.createUserWithEmailAndPassword(
      name,
      email,
      password,
    );
    result.fold(
      (failure) => emit(FirebaseSignUpFailure(message: failure.message)),
      (userEntity) => emit(FirebaseSignUpSuccess(userEntity: userEntity)),
    );
  }
}
