import 'package:flutter/material.dart';
import 'package:heraf/ui/widgets/constants.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/back.png'), fit: BoxFit.cover)),
        height: size.height,
        width: size.width,
        child: Center(
          child: Logo(
            size: size.width * .8,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
