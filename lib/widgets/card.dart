import 'package:flutter/material.dart';

Card card(
    String title, String subtitle, String value, void Function()? submit) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    margin: EdgeInsets.all(15),
    elevation: 10,
    child: Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
          title: Text(title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(subtitle),
              Text(value),
            ],
          ),
          leading: Icon(Icons.home),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            MaterialButton(
              onPressed: submit,
              child: Text('Detalles'),
            )
          ],
        ),
      ],
    ),
  );
}
