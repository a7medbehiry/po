import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pet_app/view/chat/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final DateTime? createdAt;
  final String? profileImageUrl;
  final String? fcmToken; // Add fcmToken field if you need it

  UserModel({
    required String name,
    required String email,
    required String uId,
    required String fcmToken,
    this.createdAt,
    this.profileImageUrl,
  })  : fcmToken = fcmToken, // Initialize fcmToken here
        super(
            name: name,
            email: email,
            uId: uId,
            createdAt: createdAt,
            profileImageUrl: profileImageUrl,
            fcmToken: fcmToken);

  // Handle FirebaseUser and FirebaseMessaging asynchronously
  static Future<UserModel> fromFirebaseUser(
      User user, FirebaseMessaging message) async {
    final token = await message.getToken();
    return UserModel(
      name: user.displayName ?? '',
      email: user.email ?? '',
      uId: user.uid,
      createdAt: user.metadata.creationTime,
      profileImageUrl: user.photoURL ?? '',
      fcmToken: token ?? '',
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] as String,
      email: json['email'] as String,
      uId: json['userId'] as String,
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] as Timestamp).toDate()
          : null,
      profileImageUrl: json['profileImageUrl'] as String?,
      fcmToken:
          json['fcmToken'] as String? ?? '', // Handle fcmToken if it exists
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'userId': uId,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'profileImageUrl': profileImageUrl,
      'fcmToken': fcmToken, // Include fcmToken if needed
    };
  }
}
