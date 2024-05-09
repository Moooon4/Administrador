import 'package:administrador/components/button_sign_in.dart';
import 'package:administrador/components/iconos_signin.dart';
import 'package:administrador/components/textfields_user_pass.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget{
  LoginPage({super.key});

  // Editando controladores
  final emailController = TextEditingController();
  final passController = TextEditingController();

  // Método para el usuario
  void signUserIn() async{
    // Validando los datos
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passController.text,
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        // -* Espaciado entre widgets
        const SizedBox(height: 40),
        // -*
        // Logo
        const Icon(
          Icons.lock,
          size: 100,
        ),
        // -* Espaciado entre widgets
        const SizedBox(height: 40),
        // -*
        // Welcome
        Text(
          'Ingreso',
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 45),
        // Email
        TextsFields(
          controller: emailController,
          hintText: 'Email',
          obscureText: false,
        ),
        const SizedBox(height: 50),
        // Password
        TextsFields(
          controller: passController,
          hintText: 'Password',
          obscureText: false,
        ),
        // -* Espaciado entre widgets
        const SizedBox(height: 25),
        // -*
        // Forgot pass
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '¿Olvidaste tu contraseña?',
                    style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 25),
        // Sign in
        ButtonSignIn(
          onTap: signUserIn,
        ),
        // -* Espaciado entre widgets
        const SizedBox(height: 50),
        // -*
        // or continue
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            children: [
              Expanded(
                child: Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'O ingresa desde',
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ),
        // -* Espaciado entre widgets
        const SizedBox(height: 25),
        // -*
        // google + apple
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // google button
            IconosSignIn(iconosAg: 'lib/assets/google.png'),
            SizedBox(width: 25),
            // apple button
            IconosSignIn(iconosAg: 'lib/assets/apple.png'),
          ],
        ),
        // -* Espaciado entre widgets
        const SizedBox(height: 30),
        // -*
        // Register now
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text(
              '¿No eres administrador?',
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(width: 4),
            const Text(
              'Registrate',
              style: TextStyle(color: Colors.blue,
              fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],),
    );
  }
}