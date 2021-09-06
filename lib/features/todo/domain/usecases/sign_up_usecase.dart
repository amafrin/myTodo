import 'package:flutter_clean_architechture/features/todo/domain/entities/user_entities.dart';
import 'package:flutter_clean_architechture/features/todo/domain/repositories/firebase_repositories.dart';

class SignUpUseCase {

  final FirebaseRepository repository;

  SignUpUseCase({this.repository});

  Future<void> call(UserEntity user)async{
    return repository.signUp(user);
  }
}