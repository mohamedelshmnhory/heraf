import 'package:flutter/material.dart';
import 'package:heraf/providers/auth.dart';
import 'package:heraf/ui/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Text(
              "الإعدادات",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 30),
            Divider(thickness: .5, color: Color(0xff9DDFD3)),
            settingItem(context, () {}, Icons.person, "حسابي"),
            settingItem(context, () {}, Icons.share, "شارك التطبيق"),
            settingItem(context, () {
              Provider.of<Auth>(context, listen: false).logout();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => WelcomeScreen()));
            }, Icons.exit_to_app, "تسجيل الخروج"),
            settingItem(context, () {}, Icons.handyman, "معلومات عنا"),
          ],
        ),
      ),
    );
  }

  GestureDetector settingItem(BuildContext context, onTap, icon, text) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(width: 30),
                Icon(
                  icon,
                  color: Theme.of(context).accentColor,
                ),
                SizedBox(width: 20),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Divider(thickness: .5, color: Color(0xff9DDFD3)),
        ],
      ),
    );
  }
}
