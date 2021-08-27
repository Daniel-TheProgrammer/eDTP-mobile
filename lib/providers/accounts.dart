import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import './account.dart';

class Accounts with ChangeNotifier {
  List<Account> _details = [];

  final String authToken;
  final String userId;

  Accounts(this.authToken, this.userId, this._details);

  List<Account> get details {
    return [..._details];
  }

  Account findById(String id) {
    return _details.firstWhere((user) => user.id == id);
  }

  Future<void> fetchAndSetAccountDetails([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url =
        'https://yourproject-username-default-rtdb.firebaseio.com/AccountDetails.json?auth=$authToken&$filterString';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addAccountDetails(Account account) async {
    final url =
        'https://shopify-5113b-default-rtdb.firebaseio.com/AccountDetails.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'name': account.name,
          'address': account.address,
          'phonenumber': account.phonenumber,
          'dateofbirth': account.dateofbirth,
          'creatorId': userId,
        }),
      );
      final newAccountDetails = Account(
        name: account.name,
        phonenumber: account.phonenumber,
        address: account.address,
        dateofbirth: account.dateofbirth,
        id: json.decode(response.body)['name'],
      );
      _details.add(newAccountDetails);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateAccountDetails(
      String id, Account newAccountDetails) async {
    final userIndex = _details.indexWhere((user) => user.id == id);
    if (userIndex >= 0) {
      final url =
          'https://shopify-5113b-default-rtdb.firebaseio.com/AccountDetails/$id.json?auth=$authToken';
      await http.patch(url,
          body: json.encode({
            'name': newAccountDetails.name,
            'address': newAccountDetails.address,
            'phonenumber': newAccountDetails.phonenumber,
          }));
      _details[userIndex] = newAccountDetails;
      notifyListeners();
    } else {
      print('...');
    }
  }
}
