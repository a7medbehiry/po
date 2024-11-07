

import 'package:pet_app/view/authentication/social_login/data/repos/auth_repo_impl.dart';
import 'package:pet_app/view/chat/services/get_it_service.dart';

import 'data/firebase_auth_service.dart';
import 'domain/repos/auth_repo.dart';

void setupGettItt() {
  getIt.registerSingleton<FirebaseAuthServicee>(FirebaseAuthServicee());

  getIt.registerSingleton<AuthRepoo>(
    AuthRepoImpl(
      firebaseAuthService: getIt<FirebaseAuthServicee>(),
    ),
  );
}
