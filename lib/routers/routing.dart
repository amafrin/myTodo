import 'package:flutter/material.dart';
import 'package:flutter_clean_architechture/constants/routing_constants.dart';
import 'package:flutter_clean_architechture/features/splash_screen.dart';
import 'package:flutter_clean_architechture/features/todo/presentation/pages/home_page.dart';
import 'package:flutter_clean_architechture/features/todo/presentation/pages/sign_in_page.dart';
import 'package:flutter_clean_architechture/features/todo/presentation/pages/sign_up_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RoutingConstants.routeDefault:
        return MaterialPageRoute(builder: (_) => SplashScreen());
        break;

      case RoutingConstants.routeToSignIn:
        return MaterialPageRoute(builder: (_) => SignInPage());
        break;

      case RoutingConstants.routeToSignUp:
        return MaterialPageRoute(builder: (_) => SignUpPage());
        break;
      case RoutingConstants.routeToHomePage:
        return MaterialPageRoute(builder: (_) => HomePage());
        break;

      default:
        return _errorRoute(settings.name);
    }
  }

  static Route<dynamic> _errorRoute(pageName) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.error_outline),
              Text(
                RoutingConstants.errPageText + pageName.toString(),
                style: TextStyle(fontSize: 18.0),
              )
            ],
          ),
        ),
      );
    });
  }
}
