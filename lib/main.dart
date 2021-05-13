import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:heraf/providers/auth.dart';
import 'package:heraf/providers/laborers.dart';
import 'package:heraf/ui/screens/laborer_screen.dart';
import 'package:heraf/ui/screens/user_screen.dart';
import 'package:heraf/ui/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

import 'ui/screens/splash.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // _initFcm();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (_) => Laborers(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Flutter Demo',
          // onGenerateRoute: generateRoute,
          navigatorKey: navigatorKey,
          theme: ThemeData(
            fontFamily: 'BoutrosMBCDinkum',
            accentColor: Color(0xffffc93c),
            primarySwatch: Colors.blue,
            primaryColor: Color(0xff252655),
            primaryColorLight: Color(0xff31326f),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  Color.lerp(Color(0xff252655), Color(0xff191938), .5)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            )),
            canvasColor: Color.fromRGBO(219, 246, 233, 1),
          ),
          home: auth.isAuth
              ? auth.isUser
                  ? UserScreen()
                  : LaborerScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? Splash()
                          : WelcomeScreen(),
                ),
        ),
      ),
    );
  }
}
