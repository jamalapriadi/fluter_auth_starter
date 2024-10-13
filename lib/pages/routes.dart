import 'package:flutter/material.dart';
import '../pages/auth/login.dart';
import '../pages/auth/password.dart';
import '../pages/auth/register.dart';
import '../pages/home.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/login":
        return MaterialPageRoute(builder: (_) => const Login());
      case "/password":
        return MaterialPageRoute(builder: (_) => const Password());
      case "/register":
        return MaterialPageRoute(builder: (_) => const Register());
      case "/home":
      case "/":
        return MaterialPageRoute(builder: (_) => const Home());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: const Center(
          child: Text("Erroor Page"),
        ),
      );
    });
  }
}
