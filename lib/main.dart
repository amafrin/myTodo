import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architechture/constants/string_constants.dart';
import 'package:flutter_clean_architechture/features/todo/presentation/cubit/auth/auth_cubit.dart';
import 'package:flutter_clean_architechture/features/todo/presentation/cubit/user/user_cubit.dart';
import 'package:flutter_clean_architechture/features/todo/presentation/pages/sign_in_page.dart';
import 'package:flutter_clean_architechture/features/todo/presentation/pages/home_page.dart';

import 'package:flutter_clean_architechture/constants/routing_constants.dart';
import 'package:flutter_clean_architechture/features/todo/presentation/pages/sign_up_page.dart';
import 'package:flutter_clean_architechture/routers/routing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'injection_todo.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
            create: (_) => di.sl<AuthCubit>()..appStarted()),
        BlocProvider<UserCubit>(create: (_) => di.sl<UserCubit>()),
      ],
      child: MaterialApp(
        title: StringConstants.appName,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: RoutingConstants.routeDefault,
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (context) {
            return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
              if (authState is Authenticated) {
                return HomePage();
              } else if (authState is UnAuthenticated) {
                return SignInPage();
              } else {
                return SignInPage();
              }
            });
          }
        },
      ),
    );
  }
}
