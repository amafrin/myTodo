import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_clean_architechture/features/todo/data/datasource/firebase_datasource.dart';
import 'package:flutter_clean_architechture/features/todo/data/model/user_model.dart';
import 'package:flutter_clean_architechture/features/todo/domain/entities/user_entities.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  FirebaseRemoteDataSourceImpl({this.auth, this.firestore});
  @override
  Future<void> getCreateCurrentUser(UserEntity user) async {
    final userCollectionRef = firestore.collection("users");
    final uid = await getCurrentUId();

    userCollectionRef.doc(uid).get().then((value) {
      final newUser = UserModel(
        uid: uid,
        name: user.name,
        email: user.email,
        status: user.status,
      ).toDocument();

      //only new user record will insert
      if (!value.exists) {
        userCollectionRef.doc(uid).set(newUser);
      }
      return;
    });
  }

  @override
  Future<String> getCurrentUId() async {
    return auth.currentUser.uid;
  }

  @override
  Future<bool> isSignIn() async {
    print("is sign in calling");
    return auth.currentUser.uid != null;
    // if (auth.currentUser.uid != null) {
    //   print("calleinh");
    //   return true;
    // } else {
    //   print("false atats");
    //   return false;
    // }
  }

  @override
  Future<void> signIn(UserEntity user) {
    return auth.signInWithEmailAndPassword(
        email: user.email, password: user.password);
  }

  @override
  Future<void> signOut() {
    return auth.signOut();
  }

  @override
  Future<void> signUp(UserEntity user) {
    return auth.createUserWithEmailAndPassword(
        email: user.email, password: user.password);
  }
}
