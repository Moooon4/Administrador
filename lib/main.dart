import 'package:administrador/pages/add_name_page.dart';
import 'package:administrador/pages/edit_name_page.dart';
import 'package:administrador/pages/home_page.dart';
import 'package:administrador/pages/orders_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
    Widget build(BuildContext context) {
      return MaterialApp(
      title: 'Administrador Chilín',
      initialRoute: '/',
      routes: {
        //'/': (context) => LoginPage(),
        '/': (context) => const Home(),
        '/add': (context) => const AddNamePage(),
        '/edit': (context) => const EditNamePage(),
        '/orders': (context) => const OrdersPage(),
        //'/auth': (context) => const AuthPage(),
      },
    );
  }
}

