import 'package:flutter_clean_architechture/features/todo/domain/entities/user_entities.dart';

abstract class FirebaseRemoteDataSource {
  Future<bool> isSignIn();
  Future<void> signIn(UserEntity user);
  Future<void> signUp(UserEntity user);
  Future<void> signOut();
  Future<String> getCurrentUId();
  Future<void> getCreateCurrentUser(UserEntity user);
}
