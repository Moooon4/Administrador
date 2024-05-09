import 'package:administrador/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          // Administrador logged
          if(snapshot.hasData){
            return const Home();
          }
          // Administrador NO logged
          else{
            return const AuthPage();
          }
        },
      ),
    );
  }
}