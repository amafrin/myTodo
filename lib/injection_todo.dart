import 'package:flutter_clean_architechture/features/todo/data/datasource/firebase_datasource.dart';
import 'package:flutter_clean_architechture/features/todo/data/datasource/firebase_datasource_impl.dart';
import 'package:flutter_clean_architechture/features/todo/data/repositories/firebase_repository_impl.dart';
import 'package:flutter_clean_architechture/features/todo/domain/repositories/firebase_repositories.dart';
import 'package:flutter_clean_architechture/features/todo/domain/usecases/get_create_current_user_usecase.dart';
import 'package:flutter_clean_architechture/features/todo/domain/usecases/get_current_uid_usecase.dart';
import 'package:flutter_clean_architechture/features/todo/domain/usecases/is_sign_in_usecase.dart';
import 'package:flutter_clean_architechture/features/todo/domain/usecases/sign_in_usecase.dart';
import 'package:flutter_clean_architechture/features/todo/domain/usecases/sign_out_usecase.dart';
import 'package:flutter_clean_architechture/features/todo/domain/usecases/sign_up_usecase.dart';
import 'package:flutter_clean_architechture/features/todo/presentation/cubit/auth/auth_cubit.dart';
import 'package:flutter_clean_architechture/features/todo/presentation/cubit/user/user_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  /* Cubit/Bloc */

  sl.registerFactory<AuthCubit>(() => AuthCubit(
      getCurrentUidUseCase: sl.call(),
      signOutUseCase: sl.call(),
      isSignInUseCase: sl.call()));

  sl.registerFactory<UserCubit>(() => UserCubit(
      getCreateCurrentUserUseCase: sl.call(),
      signInUseCase: sl.call(),
      signUpUseCase: sl.call()));

  //Use Cases
  sl.registerLazySingleton<GetCreateCurrentUserUsecase>(
      () => GetCreateCurrentUserUsecase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUidUseCase>(
      () => GetCurrentUidUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton<IsSignInUseCase>(
      () => IsSignInUseCase(repository: sl.call()));

  //Repositories
  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(remoteDataSource: sl.call()));

  //Data Source
  sl.registerLazySingleton<FirebaseRemoteDataSource>(() =>
      FirebaseRemoteDataSourceImpl(auth: sl.call(), firestore: sl.call()));

  //External
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
}
