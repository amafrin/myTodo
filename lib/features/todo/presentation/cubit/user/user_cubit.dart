import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_clean_architechture/features/todo/domain/entities/user_entities.dart';
import 'package:flutter_clean_architechture/features/todo/domain/usecases/get_create_current_user_usecase.dart';
import 'package:flutter_clean_architechture/features/todo/domain/usecases/sign_in_usecase.dart';
import 'package:flutter_clean_architechture/features/todo/domain/usecases/sign_up_usecase.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final GetCreateCurrentUserUsecase getCreateCurrentUserUseCase;
  UserCubit(
      {this.signInUseCase,
      this.signUpUseCase,
      this.getCreateCurrentUserUseCase})
      : super(UserInitial());

  Future<void> submitSignIn({UserEntity user}) async {
    emit(UserLoading());
    try {
      await signInUseCase.call(user);
      emit(UserSuccess());
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }

  Future<void> submitSignUp({UserEntity user}) async {
    emit(UserLoading());
    try {
      await signUpUseCase.call(user);
      //after signUp creating new user account
      await getCreateCurrentUserUseCase.call(user);
      emit(UserSuccess());
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }
}
