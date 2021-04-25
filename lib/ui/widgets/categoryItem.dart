import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({Key key, @required this.size, @required this.category})
      : super(key: key);

  final Size size;
  final category;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          height: size.height * .18,
          width: size.width * .45,
          decoration: BoxDecoration(
              color: Color(0xff9DDFD3),
              borderRadius: BorderRadius.circular(29)),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              category.icon,
              semanticsLabel: category.name,
              width: size.width * .3,
              height: size.height * .15,
              color: Theme.of(context).primaryColorLight,
            ),
            SizedBox(
              height: size.height * .02,
            ),
            Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                height: size.height * .05,
                width: size.width * .4,
                child: Center(
                  child: Text(
                    category.name,
                    style: TextStyle(
                        fontSize: 17, color: Theme.of(context).primaryColor),
                  ),
                )),
          ],
        ),
      ],
    );
  }
}
