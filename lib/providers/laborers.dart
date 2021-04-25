import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:heraf/models/user.dart';
import 'package:http/http.dart' as http;

class Laborers with ChangeNotifier {
  List<UserDetails> laborers = [];
  bool loading = false;

  Future<void> fetchAndSetLaborers(String category, String token) async {
    loading = true;
    notifyListeners();
    laborers = await fetchLaborers(category, token);
    loading = false;
    notifyListeners();
  }
}

Future<List<UserDetails>> fetchLaborers(String category, String token) async {
  final List<UserDetails> loadedList = [];
  String url =
      'https://heraf-2acd3-default-rtdb.firebaseio.com/users.json?auth=$token&orderBy="category"&equalTo="$category"&print=pretty';
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return [];
      }
      extractedData.forEach((id, item) {
        loadedList.add(UserDetails(
          docId: id,
          id: item['UserId'],
          name: item['name'],
          photo: item['photo'],
          phone: item['phone'],
          email: item['email'],
          password: item['password'],
          address: item['address'],
          type: item['type'],
          category: item['category'],
          rate: item['rate'],
        ));
      });
    }
  } on Exception catch (e) {
    print(e);
    // TODO
  }

  return loadedList;
}
