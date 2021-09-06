import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architechture/constants/routing_constants.dart';
import 'package:flutter_clean_architechture/constants/string_constants.dart';
import 'package:flutter_clean_architechture/features/todo/presentation/cubit/auth/auth_cubit.dart';
import 'package:flutter_clean_architechture/features/todo/presentation/cubit/user/user_cubit.dart';
import 'package:flutter_clean_architechture/features/todo/presentation/pages/home_page.dart';
import 'package:flutter_clean_architechture/features/todo/presentation/widgets/common.dart';
import 'package:flutter_clean_architechture/features/todo/presentation/widgets/textform_widget.dart';
import 'package:flutter_clean_architechture/features/todo/presentation/widgets/button_widget.dart';
import 'package:flutter_clean_architechture/features/todo/domain/entities/user_entities.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldGlobalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldGlobalKey,
        body: BlocConsumer<UserCubit, UserState>(
          builder: (context, userState) {
            if (userState is UserSuccess) {
              return BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, authState) {
                if (authState is Authenticated) {
                  return HomePage();
                } else {
                  return bodyWidget();
                }
              });
            }

            return bodyWidget();
          },
          listener: (context, userState) {
            if (userState is UserSuccess) {
              BlocProvider.of<AuthCubit>(context).loggedIn();
            }
            if (userState is UserFailure) {
              snackBarError(
                  msg: "invalid email", scaffoldState: _scaffoldGlobalKey);
            }
          },
        ));
  }

  bodyWidget() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              StringConstants.signInText,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormWidget(
              controller: emailController,
              isPass: false,
              hintText: StringConstants.emailHintText,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormWidget(
              controller: passwordController,
              isPass: true,
              hintText: StringConstants.passHintText,
            ),
            SizedBox(
              height: 50,
            ),
            ButtonWidget(
              buttonText: StringConstants.signInText,
              onTap: () {
                submitSignIn();
              },
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(StringConstants.accText1),
                TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(RoutingConstants.routeToSignUp);
                    },
                    child: Text(
                      StringConstants.signUpText,
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  void submitSignIn() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      BlocProvider.of<UserCubit>(context).submitSignIn(
          user: UserEntity(
        email: emailController.text,
        password: passwordController.text,
      ));
    }
  }
}
