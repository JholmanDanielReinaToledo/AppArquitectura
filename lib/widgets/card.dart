import 'package:flutter/material.dart';

Card card(String title, String subtitle, void Function()? submit) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    margin: EdgeInsets.all(15),
    elevation: 10,
    child: Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
          title: Text(title),
          subtitle: Text(subtitle),
          leading: Icon(Icons.home),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
              onPressed: submit,
              child: Text('Detalles'),
            )
          ],
        ),
      ],
    ),
  );
}
