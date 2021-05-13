import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heraf/ui/screens/laborersList_screen.dart';
import 'package:heraf/ui/widgets/constants.dart';

import 'categoryItem.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GridView.builder(
      itemCount: listOfCategories.length,
      itemBuilder: (c, i) => GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return LaborersScreen(category: listOfCategories[i].name);
            },
          ));
        },
        child: CategoryItem(
          size: size,
          category: listOfCategories[i],
        ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
    );
  }
}
