import 'dart:io';

import 'package:flutter/material.dart';
import 'package:heraf/models/user.dart';
import 'package:heraf/providers/auth.dart';
import 'package:heraf/ui/widgets/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  static const routeName = '/signUp';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final List _listOfCat = listOfCategories.map((e) => e.name).toList();
  UserDetails user = UserDetails();
  String email;
  String password;
  String name;
  String address;
  String phone;
  File photo;
  var selectedType;
  bool errorOfType = false;
  var selectedCat;
  bool errorOfCat = false;

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
                  margin: EdgeInsets.only(bottom: 30),
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(32)),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          width: size.width,
                          child: CircleAvatar(
                            radius: size.width * 0.2,
                            backgroundColor: Colors.white54,
                            child: photo == null
                                ? GestureDetector(
                                    onTap: () {
                                      getImage();
                                    },
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 50,
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      getImage();
                                    },
                                    child: CircleAvatar(
                                      radius: size.width * 0.2,
                                      backgroundImage: FileImage(photo),
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration:
                              loginTextFieldDecoration("الاسم", context),
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value.isEmpty || value.length < 2) {
                              return 'ادخل قيمه صحيحه';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            name = value;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration:
                              loginTextFieldDecoration("العنوان", context),
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            if (value.isEmpty || value.length < 2) {
                              return 'ادخل قيمه صحيحه';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            address = value;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration:
                              loginTextFieldDecoration("رقم الهاتف", context),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty || value.length < 10) {
                              return 'ادخل قيمه صحيحه';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            phone = value;
                          },
                        ),
                        SizedBox(height: 20),
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
                        DropdownButton(
                          elevation: 0,
                          isExpanded: true,
                          icon: Icon(
                            !errorOfType
                                ? Icons.arrow_circle_down_rounded
                                : Icons.error_outline,
                            color: !errorOfType
                                ? Theme.of(context).primaryColor
                                : Colors.red,
                          ),
                          hint: Text(
                            'نوع الحساب',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                          ),
                          value: selectedType,
                          onChanged: (value) {
                            setState(() {
                              selectedType = value;
                              errorOfType = false;
                            });
                          },
                          items: ["زبون", "حرفي"].map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    item,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                        if (selectedType == "حرفي")
                          DropdownButton(
                            elevation: 0,
                            isExpanded: true,
                            icon: Icon(
                              !errorOfCat
                                  ? Icons.arrow_circle_down_rounded
                                  : Icons.error_outline,
                              color: !errorOfCat
                                  ? Theme.of(context).primaryColor
                                  : Colors.red,
                            ),
                            hint: Text(
                              'الحرفه',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                            ),
                            value: selectedCat,
                            onChanged: (value) {
                              setState(() {
                                selectedCat = value;
                                errorOfCat = false;
                              });
                            },
                            items: _listOfCat.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      item,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
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
    if (!_formKey.currentState.validate() ||
        selectedType == null ||
        (selectedType == 'حرفي' && selectedCat == null)) {
      // Invalid!
      if (selectedCat == null) {
        setState(() {
          errorOfCat = true;
        });
        return;
      }
      if (selectedType == null) {
        setState(() {
          errorOfType = true;
        });
        return;
      }
      return;
    }
    _formKey.currentState.save();
    user = UserDetails(
        name: name,
        address: address,
        phone: phone,
        email: email,
        type: selectedType,
        category: selectedCat,
        password: password);
    try {
      await Provider.of<Auth>(context, listen: false)
          .signUp(userDetails: user, photo: photo, context: context);
    } catch (error) {
      print(error);
    }
  }

  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    // File compressedImage =
    //     await FlutterNativeImage.compressImage(image.path, quality: 70);
    setState(() {
      if (pickedFile != null) {
        photo = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    // }
  }
}
