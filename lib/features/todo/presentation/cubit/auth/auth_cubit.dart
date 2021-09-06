import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_clean_architechture/features/todo/domain/usecases/get_create_current_user_usecase.dart';
import 'package:flutter_clean_architechture/features/todo/domain/usecases/get_current_uid_usecase.dart';
import 'package:flutter_clean_architechture/features/todo/domain/usecases/is_sign_in_usecase.dart';
import 'package:flutter_clean_architechture/features/todo/domain/usecases/sign_out_usecase.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final GetCurrentUidUseCase getCurrentUidUseCase;
  final IsSignInUseCase isSignInUseCase;
  final SignOutUseCase signOutUseCase;

  AuthCubit(
      {this.getCurrentUidUseCase, this.isSignInUseCase, this.signOutUseCase})
      : super(AuthInitial());

  Future<void> appStarted() async {
    try {
      final isSignIn = await isSignInUseCase.call();
      if (isSignIn) {
        final uid = await getCurrentUidUseCase.call();
        emit(Authenticated(uid: uid));
      } else {
        emit(UnAuthenticated());
      }
    } on SocketException catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    try {
      final uid = await getCurrentUidUseCase.call();
      emit(Authenticated(uid: uid));
    } on SocketException catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedOut() async {
    try {
      await signOutUseCase.call();
      emit(UnAuthenticated());
    } on SocketException catch (_) {
      emit(UnAuthenticated());
    }
  }
}
