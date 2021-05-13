import 'package:flutter/material.dart';
import 'package:heraf/ui/screens/login.dart';
import 'package:heraf/ui/screens/signUp.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(height: 20),
            Image.asset(
              'assets/1.png',
              height: size.height * .4,
              width: double.infinity,
            ),
            Container(
              width: size.width * .8,
              child: Text(
                'يُمْكِنُك تَطْبِيق "حِرَف " مِنْ سُهُولَةِ التَّوَاصُل يُنْك وَبَيْن صَاحِبُ الْعَمَلِ والفنى وَتَحْدِيد السِّعْر قَبْلَ الْعَمَلِ لِضَمَان أَعْلَى جُودِه وَسُعُر .',
                style: TextStyle(
                    fontSize: 17, color: Theme.of(context).primaryColor),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Login();
                    },
                  ),
                );
              },
              child: Text(
                'الدخول',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 100, vertical: 10))),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUp();
                      },
                    ),
                  );
                },
                child: Text(
                  'مستخدم جديد',
                  style: TextStyle(
                      fontSize: 17,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}
