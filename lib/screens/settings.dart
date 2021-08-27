import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import '../main.dart';

void main() => runApp(Settings());

class Settings extends StatefulWidget {
  static const routeName = '/settings';
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    var actionItems = getListOfActionButtons();
    return MaterialApp(
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.cyan,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pushNamed('/'),
              ),
              title: const Text(
                'App Settings',
                style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[Colors.cyan[700], Colors.cyan[200]])),
              ),
            ),
            body: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 2,
                children: List.generate(actionItems.length, (index) {
                  return Center(
                      child: ButtonTheme(
                    minWidth: 150.0,
                    child: actionItems[index],
                  ));
                }))));
  }

  List<Widget> getListOfActionButtons() {
    var actionItems = <Widget>[];

    actionItems.addAll([
      RaisedButton.icon(
        icon: Icon(Icons.wifi),
        color: Colors.cyan[200],
        label: Text(
          "WIFI",
          style: TextStyle(
              fontSize: 18, fontFamily: 'Raleway', fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          AppSettings.openWIFISettings();
        },
      ),
      RaisedButton.icon(
        icon: Icon(Icons.location_pin),
        color: Colors.cyan[200],
        label: Text(
          "Location",
          style: TextStyle(
              fontSize: 18, fontFamily: 'Raleway', fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          AppSettings.openLocationSettings();
        },
      ),
      RaisedButton.icon(
        icon: Icon(Icons.security_rounded),
        color: Colors.cyan[200],
        label: Text(
          "Security",
          style: TextStyle(
              fontSize: 18, fontFamily: 'Raleway', fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          AppSettings.openSecuritySettings();
        },
      ),
      RaisedButton.icon(
        icon: Icon(Icons.settings_outlined),
        color: Colors.cyan[200],
        label: Text(
          "App Settings",
          style: TextStyle(
              fontSize: 18, fontFamily: 'Raleway', fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          AppSettings.openAppSettings();
        },
      ),
      RaisedButton.icon(
        icon: Icon(Icons.calendar_today),
        color: Colors.cyan[200],
        label: Text(
          "Date",
          style: TextStyle(
              fontSize: 18, fontFamily: 'Raleway', fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          AppSettings.openDateSettings();
        },
      ),
      RaisedButton.icon(
        icon: Icon(Icons.wb_sunny),
        color: Colors.cyan[200],
        label: Text(
          "Display",
          style: TextStyle(
              fontSize: 18, fontFamily: 'Raleway', fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          AppSettings.openDisplaySettings();
        },
      ),
      RaisedButton.icon(
        icon: Icon(Icons.notifications),
        color: Colors.cyan[200],
        label: Text(
          "Notification",
          style: TextStyle(
              fontSize: 18, fontFamily: 'Raleway', fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          AppSettings.openNotificationSettings();
        },
      ),
      RaisedButton.icon(
        padding: EdgeInsets.only(right: 5),
        icon: Icon(Icons.sd_storage_outlined),
        color: Colors.cyan[200],
        label: Text(
          "Internal Storage",
          style: TextStyle(
              fontSize: 18, fontFamily: 'Raleway', fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          AppSettings.openInternalStorageSettings();
        },
      ),
    ]);

    return actionItems;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
