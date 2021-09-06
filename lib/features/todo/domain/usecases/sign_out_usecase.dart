import 'package:flutter_clean_architechture/features/todo/domain/repositories/firebase_repositories.dart';

class SignOutUseCase {

  final FirebaseRepository repository;

  SignOutUseCase({this.repository});

  Future<void> call()async{
    
    return repository.signOut();
  }
}