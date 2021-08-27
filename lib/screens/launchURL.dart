import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import '../widgets/app_drawer.dart';
import 'dart:io';

import 'package:mailto/mailto.dart';

class LaunchUrlDemo extends StatefulWidget {
  static const routeName = '/launch';

  LaunchUrlDemo({Key key}) : super(key: key);
  final String title = 'Contact Us';

  @override
  _LaunchUrlDemoState createState() => _LaunchUrlDemoState();
}

class _LaunchUrlDemoState extends State<LaunchUrlDemo> {
  Future<void> _launched;
  String phoneNumber = '';

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _sendSMS() async {
    const ur = 'sms:1234567890';
    if (await canLaunch(ur)) {
      await launch(ur);
    } else {
      throw 'Could not launch $ur';
    }
  }

  _sendMail() async {
    const uri =
        'mailto:shopifyapplication7579@gmail.com?subject=Customer%20Query';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
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
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Image.asset('assets/images/shop2.png'),
            SizedBox(height: 10),
            Text(
              'SHOPIFY',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: 300,
              height: 70,
              padding: const EdgeInsets.all(10),
              child: RaisedButton(
                splashColor: Colors.white,
                color: Colors.cyan[100],
                child: Row(
                  children: <Widget>[
                    Text(
                      "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t",
                    ),
                    Center(child: Icon(Icons.email, size: 30)),
                    Text(
                      "\t\t\tEmail",
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      softWrap: true,
                    )
                  ],
                ),
                onPressed: () {
                  setState(() {
                    _sendMail();
                  });
                },
              ),
            ),
            Container(
              width: 300,
              height: 70,
              padding: const EdgeInsets.all(10),
              child: RaisedButton(
                splashColor: Colors.white,
                color: Colors.cyan[100],
                child: Row(
                  children: <Widget>[
                    Text(
                      "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t",
                    ),
                    Center(child: Icon(Icons.phone, size: 30)),
                    Text(
                      "\t\t\tPhone",
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      softWrap: true,
                    )
                  ],
                ),
                onPressed: () {
                  setState(() {
                    _launched = _makePhoneCall('tel:1234567890');
                  });
                },
              ),
            ),
            Container(
              width: 300,
              height: 70,
              padding: const EdgeInsets.all(10),
              child: RaisedButton(
                splashColor: Colors.white,
                color: Colors.cyan[100],
                child: Row(
                  children: <Widget>[
                    Text(
                      "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t",
                    ),
                    Center(child: Icon(Icons.sms, size: 30)),
                    Text(
                      "\t\t\tSMS",
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      softWrap: true,
                    )
                  ],
                ),
                onPressed: () {
                  setState(() {
                    _launched = _sendSMS();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
