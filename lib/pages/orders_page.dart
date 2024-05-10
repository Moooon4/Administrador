import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Agregando nombre a la pantalla AÑADIR PRODUCTO
        title: Row(
          children: [
            Image.asset('lib/assets/logotenedorcuchillo.png', scale: 18),
            const SizedBox(
              width: 8,
            ),
            const Text(
              'ADD PRODUCT',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}