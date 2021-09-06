import 'package:flutter/material.dart';
import 'package:flutter_clean_architechture/features/todo/presentation/cubit/auth/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<AuthCubit>(context).loggedOut();
              },
              icon: Icon(Icons.exit_to_app)),
        ],
      ),
      body: WillPopScope(
        onWillPop: (){
          Navigator.of(context).pop();
        },
        child: Center(
          child: Container(
            child: Text("welcome dear user"),
          ),
        ),
      ),
    );
  }
}
