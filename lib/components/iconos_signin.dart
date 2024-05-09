import 'package:flutter/material.dart';

class IconosSignIn extends StatelessWidget {
  final String iconosAg;
  const IconosSignIn({
    super.key,
    required this.iconosAg,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[200],
      ),
      child: Image.asset(iconosAg, height: 35,),
    );
  }
}