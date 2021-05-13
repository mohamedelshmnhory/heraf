import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:heraf/models/user.dart';
import 'package:heraf/providers/auth.dart';
import 'package:heraf/ui/widgets/constants.dart';
import 'package:heraf/ui/widgets/messages.dart';
import 'package:heraf/ui/widgets/orders.dart';
import 'package:heraf/ui/widgets/setting_screen.dart';
import 'package:provider/provider.dart';

class LaborerScreen extends StatefulWidget {
  @override
  _LaborerScreenState createState() => _LaborerScreenState();
}

class _LaborerScreenState extends State<LaborerScreen> {
  UserDetails user = UserDetails();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final user0 = Provider.of<Auth>(context, listen: false).userDetails;
      FirebaseMessaging.instance.getToken().then((token) {
        user = UserDetails(
          userId: user0.userId,
          name: user0.name,
          email: user0.email,
          password: user0.password,
          address: user0.address,
          phone: user0.phone,
          photo: user0.photo,
          category: user0.category,
          rate: user0.rate,
          type: user0.type,
          token: token,
        );
        Provider.of<Auth>(context, listen: false).updateUser(user);
      });
    });
  }

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
                    unselectedLabelColor: Theme.of(context).accentColor,
                    tabs: <Widget>[
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
