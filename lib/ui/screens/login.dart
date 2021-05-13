import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heraf/providers/auth.dart';
import 'package:heraf/ui/widgets/constants.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  String email;

  String password;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authMd = Provider.of<Auth>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/back.png'), fit: BoxFit.cover)),
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
                child: Logo(
                  size: size.width * .4,
                  fontSize: 7,
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  width: size.width * .9,
                  // height: size.height * .5,
                  padding:
                      EdgeInsets.only(right: 10, left: 10, top: 20, bottom: 20),
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(32)),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: loginTextFieldDecoration(
                              "البريد الإلكترونى", context),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty || value.length < 7) {
                              return 'ادخل قيمه صحيحه';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            email = value;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration:
                              loginTextFieldDecoration("كلمة السر", context),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          validator: (value) {
                            if (value.isEmpty || value.length < 5) {
                              return "ادخل قيمه صحيحه";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            password = value;
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            _submit(context);
                          },
                          child: authMd.loading
                              ? CircularProgressIndicator()
                              : Text(
                                  'تسجيل الدخول',
                                  style: TextStyle(fontSize: 13),
                                ),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 10))),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    try {
      await Provider.of<Auth>(context, listen: false)
          .login(email, password, context);
    } catch (error) {
      print(error);
    }
  }
}
