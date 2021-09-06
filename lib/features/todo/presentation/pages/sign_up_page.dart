import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architechture/constants/routing_constants.dart';
import 'package:flutter_clean_architechture/constants/string_constants.dart';
import 'package:flutter_clean_architechture/features/todo/domain/entities/user_entities.dart';
import 'package:flutter_clean_architechture/features/todo/presentation/cubit/auth/auth_cubit.dart';
import 'package:flutter_clean_architechture/features/todo/presentation/cubit/user/user_cubit.dart';
import 'package:flutter_clean_architechture/features/todo/presentation/widgets/button_widget.dart';
import 'package:flutter_clean_architechture/features/todo/presentation/widgets/common.dart';
import 'package:flutter_clean_architechture/features/todo/presentation/widgets/textform_widget.dart';
import 'package:flutter_clean_architechture/features/todo/presentation/pages/home_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _globalKey,
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
              snackBarError(msg: "invalid email", scaffoldState: _globalKey);
            }
          },
        ));
  }

  Widget bodyWidget() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              StringConstants.signUpText,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormWidget(
              controller: userNameController,
              isPass: false,
              hintText: StringConstants.userNameHintText,
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
              buttonText: StringConstants.signUpText,
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
                Text(StringConstants.accText2),
                TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(RoutingConstants.routeToSignIn);
                    },
                    child: Text(
                      StringConstants.signInText,
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
    if (userNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      BlocProvider.of<UserCubit>(context).submitSignUp(
          user: UserEntity(
        email: emailController.text,
        password: passwordController.text,
      ));
    }
  }
}
