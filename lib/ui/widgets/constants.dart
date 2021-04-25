import 'package:flutter/material.dart';
import 'package:heraf/models/category.dart';

loginTextFieldDecoration(text, context) {
  return InputDecoration(
    hintText: text,
    hintStyle: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20),
    filled: true,
    fillColor: Theme.of(context).canvasColor,
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    // border: InputBorder.none,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      borderSide: BorderSide(color: Colors.black12, width: 0.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black12, width: 0.0),
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black12, width: 0.0),
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
    ),
  );
}

class Logo extends StatelessWidget {
  const Logo({
    Key key,
    @required this.size,
    @required this.fontSize,
  }) : super(key: key);

  final double size;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/heraf.png',
          // height: size.height * .4,
          width: size,
        ),
        Positioned(
          left: 9,
          bottom: 3,
          child: Text(
            "مش هتحس بالأعطال",
            style: TextStyle(
                fontSize: fontSize, color: Color.fromRGBO(37, 38, 85, 1)),
          ),
        ),
      ],
    );
  }
}

final List<Category> listOfCategories = [
  Category('كهربائى', 'assets/icons/electric.svg'),
  Category('سباك', 'assets/icons/plumbing.svg'),
  Category('نجار', 'assets/icons/carpenter.svg'),
  Category('مبيض محاره', 'assets/icons/brickwall.svg'),
  Category('نقاش', 'assets/icons/paint-roller.svg'),
  Category('مبلط سيراميك', 'assets/icons/draws.svg'),
  Category('فنى أجهزه', 'assets/icons/engineer.svg'),
  Category('فنى جيبس', 'assets/icons/roof.svg'),
];
