import 'package:flutter/material.dart';
import 'package:heraf/ui/widgets/constants.dart';
import 'package:heraf/ui/widgets/messages.dart';
import 'package:heraf/ui/widgets/orders.dart';
import 'package:heraf/ui/widgets/setting_screen.dart';

class LaborerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> taps = [
      Orders(),
      Messages(),
      SettingScreen(),
    ];
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        length: 3,
        child: SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Container(
                  height: size.height * .12,
                  // alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    // borderRadius: BorderRadius.only(
                    //   bottomLeft: Radius.circular(60.0),
                    //   bottomRight: Radius.circular(60.0),
                    // ),
                  ),
                  child: Center(
                      child: Logo(
                    size: size.width * .20,
                    fontSize: 4,
                  )),
                ),
                Expanded(
                  child: TabBarView(
                    children: taps,
                  ),
                ),
                Container(
                  color: Theme.of(context).primaryColor,
                  child: TabBar(
                    // labelColor: Theme.of(context).primaryColor,
                    // overlayColor:
                    //     MaterialStateProperty.all(Theme.of(context).primaryColor),
                    // indicatorColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: Theme.of(context).accentColor,
                    tabs: <Widget>[
                      Tab(
                        text: 'الطلبات',
                        icon: Icon(Icons.shopping_cart_rounded),
                      ),
                      Tab(
                        text: 'الرسائل',
                        icon: Icon(Icons.shopping_cart_rounded),
                      ),
                      Tab(
                        text: 'الإعدادات',
                        icon: Icon(Icons.settings),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
