import 'package:flutter/material.dart';

const kFeedbackFormFieldTextStyle = TextStyle(
  fontSize: 18.0,
  color: Colors.black87,
  fontFamily: 'Raleway',
);

const kFeedbackFormFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.cyan,
      width: 1.0,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.cyan,
      width: 2.0,
    ),
  ),
);
