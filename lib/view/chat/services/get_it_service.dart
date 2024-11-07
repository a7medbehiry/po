import 'package:get_it/get_it.dart';
import 'package:pet_app/view/chat/repos/auth_repo_impl.dart';
import 'package:pet_app/view/chat/domain/repos/auth_repo.dart';
import 'package:pet_app/view/chat/services/firebase_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  // Register services as lazy singletons to improve performance and memory usage
  getIt.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());
  getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);

  // Register the AuthRepo implementation as a lazy singleton
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      firebaseAuthService: getIt<FirebaseAuthService>(),
      firestore: getIt<FirebaseFirestore>(),
    ),
  );
}
