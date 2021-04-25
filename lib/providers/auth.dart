import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';
import 'package:heraf/models/user.dart';
import 'package:heraf/ui/screens/laborer_screen.dart';
import 'package:heraf/ui/screens/user_screen.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Auth with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool isAuth = false;
  bool isUser = false;
  bool loading = false;
  String token;
  UserDetails userDetails = UserDetails();

  Future<void> login(
      String email, String password, BuildContext context) async {
    loading = true;
    notifyListeners();
    try {
      final user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        await checkTypeOfUser(user, context);
      }
    } catch (error) {
      print(error);
    }
    loading = false;
    notifyListeners();
  }

  Future checkTypeOfUser(UserCredential user, BuildContext context) async {
    userDetails = await getUserDetails(user.user.uid, token);
    if (userDetails?.type == 'زبون') {
      isAuth = true;
      isUser = true;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => UserScreen()));
    } else {
      if (userDetails?.type == 'حرفي') {
        isAuth = true;
        isUser = false;
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => LaborerScreen()));
      }
    }
  }

  Future<void> signUp(
      {UserDetails userDetails,
      File photo,
      String type,
      String category,
      BuildContext context}) async {
    loading = true;
    notifyListeners();
    try {
      final user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: userDetails.email, password: userDetails.password);
      if (user != null) {
        await _firebaseAuth.currentUser
            .getIdToken()
            .then((tok) => token = tok)
            .then((value) async {
          try {
            await profileSetup(
                    userDetails, photo, user.user.uid, type, category)
                .then((value) async {
              if (value) {
                await checkTypeOfUser(user, context);
              }
            });
          } catch (e) {
            print(e);
            _firebaseAuth.currentUser.delete();
            // TODO
          }
        });
      }
    } catch (error) {
      print(error);
    }
    loading = false;
    notifyListeners();
  }

  Future tryAutoLogin() async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      isAuth = false;
      return false;
    } else {
      await currentUser
          .getIdToken()
          .then((tok) => token = tok)
          .then((value) async {
        userDetails = await getUserDetails(currentUser.uid, token);
      });
      if (userDetails?.type == 'زبون') {
        isAuth = true;
        isUser = true;
      } else {
        if (userDetails?.type == 'حرفي') {
          isAuth = true;
          isUser = false;
        }
      }
    }
    notifyListeners();
  }

  Future<void> logout() async {
    isAuth = false;
    _firebaseAuth.signOut();
    notifyListeners();
  }

  Future<bool> profileSetup(
    UserDetails userDetails,
    File photo,
    String userId,
    String type,
    String category,
  ) async {
    if (photo == null) {
      photo = await getImageFileFromAssets('account-image.png');
    }
    UploadTask storageUploadTask;
    storageUploadTask = FirebaseStorage.instance
        .ref()
        .child('userPhotos')
        .child(userId)
        .child(userId)
        .putFile(photo);

    return await storageUploadTask.then((ref) async {
      bool nice = false;
      await ref.ref.getDownloadURL().then((photoUrl) async {
        final url =
            "https://heraf-2acd3-default-rtdb.firebaseio.com/users/$userId.json?auth=$token";
        final response = await http.put(
          Uri.parse(url),
          body: json.encode({
            'email': userDetails.email,
            'password': userDetails.password,
            'userId': userId,
            'name': userDetails.name,
            'address': userDetails.address,
            'phone': userDetails.phone,
            'photo': photoUrl,
            'type': type,
            'category': category,
            'rate': 0.0,
          }),
        );
        if (response.statusCode == 200) {
          nice = true;
        } else {
          nice = false;
        }
      });
      return nice;
    });
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }
}

Future<UserDetails> getUserDetails(userId, token) async {
  UserDetails result;
  // final url =
  //     'https://heraf-2acd3-default-rtdb.firebaseio.com/users.json?auth=$token&orderBy="userId"&equalTo="$userId"';
  final url =
      'https://heraf-2acd3-default-rtdb.firebaseio.com/users/$userId.json?auth=$token"';
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final user = json.decode(response.body);
      result = UserDetails.fromJson(user);
      // items.forEach((id, item) {
      //   result = UserDetails(
      //     docId: id,
      //     id: item['UserId'],
      //     name: item['name'],
      //     photo: item['photo'],
      //     phone: item['phone'],
      //     email: item['email'],
      //     password: item['password'],
      //     address: item['address'],
      //     type: item['type'],
      //     category: item['category'],
      //     rate: item['rate'],
      //   );
      // });
    } else {}
  } catch (e) {
    print(e);
    // TODO
  }
  return result;
}
