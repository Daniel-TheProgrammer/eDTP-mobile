import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import './constants.dart';
import './form_field.dart';
import './raised_fab.dart';
import 'app_drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FeedbackScreen(),
    );
  }
}

class FeedbackScreen extends StatefulWidget {
  static const routeName = '/feedback';
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  List<String> _questions = [
    'How satisfied are you with the app User Interface?',
    'How likely would you recommend our app to your friends or colleagues?',
    'How would you describe your experience?',
  ];

  List<int> _feedbackValue = [];

  List<bool> _isFormFieldComplete = [];

  String additionalComments;

  void _handleRadioButton(int group, int value) {
    setState(() {
      _feedbackValue[group] = value;
      _isFormFieldComplete[group] = false;
    });
  }

  void handleSubmitFeedback() {
    bool complete = true;
    for (int i = 0; i < _feedbackValue.length; ++i) {
      if (_feedbackValue[i] == -1) {
        complete = false;
        _isFormFieldComplete[i] = true;
      } else {
        _isFormFieldComplete[i] = false;
      }
    }
    setState(() {});
    if (complete == true) {
      // setState(() => loading = true);
    }
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _questions.length; ++i) {
      _feedbackValue.add(-1);
      _isFormFieldComplete.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Customer Feedback',
          style: TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.cyan[700], Colors.cyan[200]])),
        ),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Please choose appropriate emoji icon for response',
                style: kFeedbackFormFieldTextStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '😍 - Very Satisfied',
                style: kFeedbackFormFieldTextStyle,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '☺ - Satisfied',
                style: kFeedbackFormFieldTextStyle,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '😐 - Somehow Satisfied',
                style: kFeedbackFormFieldTextStyle,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '😕 - Dissatified',
                style: kFeedbackFormFieldTextStyle,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '😠 - Very Dissatisfied',
                style: kFeedbackFormFieldTextStyle,
              ),
              Divider(
                height: 25.0,
              ),
            ]
              ..addAll(
                _questions.asMap().entries.map((entry) {
                  return FeedbackFormField(
                    id: entry.key + 1,
                    question: entry.value,
                    groupValue: _feedbackValue[entry.key],
                    radioHandler: (int value) =>
                        _handleRadioButton(entry.key, value),
                    error: _isFormFieldComplete[entry.key]
                        ? 'This is a required field'
                        : null,
                  );
                }),
              )
              ..addAll([
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  decoration: kFeedbackFormFieldDecoration.copyWith(
                    hintText: 'Additional Comments (Optional)',
                  ),
                  maxLines: 5,
                  onChanged: (value) => additionalComments = value,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  MaterialButton(
                    onPressed: () {
                      AwesomeDialog(
                        context: context,
                        animType: AnimType.SCALE,
                        customHeader: Icon(
                          Icons.favorite,
                          size: 50,
                          color: Colors.pink[300],
                        ),
                        title: 'Thank you!',
                        desc: 'We appreciate your feedback',
                        btnOk: FlatButton(
                          child: Text('Continue Shopping'),
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed('/');
                          },
                        ),
                        //btnOkOnPress: () {},
                        dismissOnTouchOutside: false,
                      ).show();
                    },
                    child: Text("Submit"),
                    color: Colors.cyan.withOpacity(0.6),
                    elevation: 40,
                  ),
                ]),
              ]),
            // RaisedButton(
            //     child: Text('Submit'),
            //     color: Colors.cyan[200],
            //     onPressed: () async {
            //       return showDialog(
            //           context: context,
            //           builder: (ctx) => AlertDialog(
            //                 //   backgroundColor: Colors.cyan[50],
            //                 title: Text('Thank you!',
            //                     style: TextStyle(
            //                         fontFamily: 'Raleway',
            //                         fontWeight: FontWeight.bold)),
            //                 content: Text(
            //                     'We appreciate your feedback.',
            //                     style:
            //                         TextStyle(fontFamily: 'Raleway')),
            //                 actions: <Widget>[
            //                   FlatButton(
            //                     child: Text(
            //                       'Continue Shopping..',
            //                       style: TextStyle(
            //                           // color: Colors.redAccent,
            //                           fontFamily: 'Raleway',
            //                           fontWeight: FontWeight.bold),
            //                     ),
            //                     onPressed: () {
            //                       Navigator.of(context)
            //                           .pushReplacementNamed('/');
            //                       // Navigator.of(ctx).pop('/');
            //                     },
            //                   ),
            //                 ],
            //               ));
            //     }),
          ),
        ),
      ),
    );
  }
}
