import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_app/view/authentication/social_login/domain/entities/user_entity.dart';

class UserModell extends UserEntityy {
  UserModell({required super.name, required super.email, required super.uId});
  factory UserModell.fromFirebaseUser(User user) {
    return UserModell(
      name: user.displayName ?? '',
      email: user.email ?? '',
      uId: user.uid,
    );
  }
}
