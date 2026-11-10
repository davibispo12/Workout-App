import 'package:app_academia/controllers/AuthController.dart';
import 'package:app_academia/pages/Home_page.dart';
import 'package:app_academia/pages/Login_page.dart';
import 'package:flutter/material.dart';

class PorteiroPage extends StatelessWidget {
  const PorteiroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Authcontroller().estadoDoLogin(), 
      builder: (context, snapshot){
       if (snapshot.connectionState == ConnectionState.waiting){
       return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
       );
       }
       if (snapshot.hasData){
        return Home_page();
       }
       else {
        return LoginPage();
       }


      }
      );
  }
}