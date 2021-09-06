import 'package:flutter_clean_architechture/features/todo/domain/repositories/firebase_repositories.dart';

class GetCurrentUidUseCase {

  final FirebaseRepository repository;

  GetCurrentUidUseCase({this.repository});

  Future<String> call()async{
    return repository.getCurrentUId();
  }
}