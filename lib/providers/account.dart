import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'accounts.dart';

class Account with ChangeNotifier {
  final String id;
  final String name;
  final String address;
  final double phonenumber;
  DateTime dateofbirth;

  Account({
    @required this.id,
    @required this.name,
    @required this.address,
    @required this.phonenumber,
    @required this.dateofbirth,
  });

  Account findById(String userId) {
    List<Account> _details = [];
    return _details.firstWhere((user) => user.id == id);
  }
}
