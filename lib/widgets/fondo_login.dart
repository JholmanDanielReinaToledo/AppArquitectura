import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FondoLogin extends StatelessWidget {
  final Widget child;
  const FondoLogin({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _CajaAzul(),
          _IconoEncabezado(),
          child,
        ],
      ),
    );
  }
}

class _CajaAzul extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(255, 8, 8, 172),
        Color.fromARGB(255, 53, 66, 255),
      ])),
    );
  }
}

class _IconoEncabezado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 40),
      child: Icon(
        Icons.person_pin_outlined,
        color: Colors.white,
        size: 100,
      ),
    ));
  }
}
