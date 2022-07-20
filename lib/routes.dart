import 'package:flutter/material.dart';
import 'package:library_application/view/login.dart';
import 'package:library_application/view/dashboard.dart';
// import 'package:test_flutter/main.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginPage());
        // break;
      // case '/dashboard':
      //   return MaterialPageRoute(builder: (_) => Dashboard());
      // //   // break;
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute(){
    return MaterialPageRoute(builder: (_){
      return Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: const Center(child: Text('Error Page')),
      );
    });
  }
}