import 'package:flutter/material.dart';
import './constants.dart';
import './radio_emoji.dart';

class FeedbackFormField extends StatelessWidget {
  FeedbackFormField(
      {@required this.id,
      @required this.question,
      @required this.groupValue,
      @required this.radioHandler,
      this.error});

  final int id;
  final String question;
  final int groupValue;
  final String error;
  final Function radioHandler;
  static final List<int> _radioButtons = [1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '$id) $question',
          style: kFeedbackFormFieldTextStyle,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _radioButtons.map((value) {
            return RadioEmoji(
              value: value,
              groupValue: groupValue,
              onChange: radioHandler,
            );
          }).toList(),
        ),
        SizedBox(
          height: 2.0,
        ),
        Visibility(
          visible: error != null,
          child: Text(
            '$error',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
