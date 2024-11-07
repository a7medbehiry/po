import 'package:dartz/dartz.dart';
import 'package:pet_app/view/chat/errors/failures.dart';
import 'package:pet_app/view/chat/domain/entities/user_entity.dart';

/// Abstract repository interface for authentication operations.
abstract class AuthRepo {
  /// Creates a new user with the provided [name], [email], and [password].
  /// Optionally, a [profileImageUrl] can be provided.
  ///
  /// Returns a [Either] with a [Failure] on the left and a [UserEntity] on the right.
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
    String name,
    String email,
    String password, {
    String? profileImageUrl, // Optional profile image URL
  });

  /// Returns a [Either] with a [Failure] on the left and a [UserEntity] on the right.
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
    String email,
    String password,
  );
}
