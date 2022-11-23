import 'package:flutter/material.dart';

Card card(String title, String subtitle, String value, DateTime fecha) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    margin: EdgeInsets.all(15),
    elevation: 10,
    child: Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.all(20),
          title: Text("Nombre: $title"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Categoria $subtitle"),
              Text("Valor: ${value.toString()}"),
              Text("Fecha: ${fecha.toString()}"),
            ],
          ),
        ),
      ],
    ),
  );
}
