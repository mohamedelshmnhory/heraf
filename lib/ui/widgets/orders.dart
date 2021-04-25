import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          color: Color(0xff9DDFD3),
          child: Text(
            "لا يوجد طلبات",
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 17, color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}
