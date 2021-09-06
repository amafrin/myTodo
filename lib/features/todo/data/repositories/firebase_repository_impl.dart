import 'package:flutter_clean_architechture/features/todo/data/datasource/firebase_datasource.dart';
import 'package:flutter_clean_architechture/features/todo/domain/entities/user_entities.dart';
import 'package:flutter_clean_architechture/features/todo/domain/repositories/firebase_repositories.dart';

class FirebaseRepositoryImpl extends FirebaseRepository {
  final FirebaseRemoteDataSource remoteDataSource;

  FirebaseRepositoryImpl({this.remoteDataSource});

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async {
    remoteDataSource.getCreateCurrentUser(user);
  }

  @override
  Future<String> getCurrentUId() async {
    remoteDataSource.getCurrentUId();
  }

  @override
  Future<bool> isSignIn() async {
    return remoteDataSource.isSignIn();
  }

  @override
  Future<void> signIn(UserEntity user) async {
    remoteDataSource.signIn(user);
  }

  @override
  Future<void> signOut() async {
    remoteDataSource.signOut();
  }

  @override
  Future<void> signUp(UserEntity user) async {
    remoteDataSource.signUp(user);
  }
}
