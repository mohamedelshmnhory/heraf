import 'package:flutter/material.dart';
import 'package:heraf/ui/widgets/categories.dart';
import 'package:heraf/ui/widgets/constants.dart';
import 'package:heraf/ui/widgets/messages.dart';
import 'package:heraf/ui/widgets/orders.dart';
import 'package:heraf/ui/widgets/setting_screen.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> taps = [
      Categories(),
      Orders(),
      Messages(),
      SettingScreen(),
    ];
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        length: 4,
        child: SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Container(
                  height: size.height * .12,
                  // alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
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
                    unselectedLabelColor: Theme.of(context).accentColor,
                    tabs: <Widget>[
                      Tab(
                        text: 'الرئيسية',
                        icon: Icon(Icons.home),
                      ),
                      Tab(
                        text: 'الطلبات',
                        icon: Icon(Icons.shopping_cart_rounded),
                      ),
                      Tab(
                        text: 'الرسائل',
                        icon: Icon(Icons.chat_outlined),
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
