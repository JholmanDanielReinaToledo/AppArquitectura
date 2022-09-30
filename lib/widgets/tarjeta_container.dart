import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TarjetaContainer extends StatelessWidget {
  final Widget child;
  const TarjetaContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        decoration: _crearTarjeta(),
        child: child,
      ),
    );
  }

  BoxDecoration _crearTarjeta() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(color: Colors.black, blurRadius: 15, offset: Offset(5, 5))
          ]);
}
