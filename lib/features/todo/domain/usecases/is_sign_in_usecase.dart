import 'package:flutter_clean_architechture/features/todo/domain/repositories/firebase_repositories.dart';

class IsSignInUseCase {
  final FirebaseRepository repository;

  IsSignInUseCase({this.repository});

  Future<bool> call() async {
    return repository.isSignIn();
  }
}
