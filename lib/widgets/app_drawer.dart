import 'package:shopify/screens/account_details.dart';

import 'package:shopify/screens/launchURL.dart';
import 'package:shopify/screens/settings.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';
import '../providers/auth.dart';
import '../helpers/custom_route.dart';
import '../screens/account_details.dart';
import './feedback.dart';
import 'search.dart';
import '../screens/about.dart';
import '../main.dart';
import '../screens/launchURL.dart';
import '../screens/settings.dart';
import '../screens/chatbot.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AppBar(
              backgroundColor: Colors.cyan,
              leading: Icon(
                Icons.home,
                size: 30,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                  fontSize: 22,
                ),
                textAlign: TextAlign.start,
              ),
              automaticallyImplyLeading: false,
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.shop,
                size: 28,
              ),
              title: Text(
                'Shop',
                style: TextStyle(fontSize: 18, fontFamily: 'QuickSand'),
              ),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.wallet_travel_rounded,
                size: 28,
              ),
              title: Text(
                'Orders',
                style: TextStyle(fontSize: 18, fontFamily: 'QuickSand'),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(OrdersScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.edit,
                size: 28,
              ),
              title: Text(
                'Manage Products',
                style: TextStyle(fontSize: 18, fontFamily: 'QuickSand'),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(UserProductsScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.account_box,
                size: 28,
              ),
              title: Text(
                'Account Details',
                style: TextStyle(fontSize: 18, fontFamily: 'QuickSand'),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(AccountDetailScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.feedback,
                size: 28,
              ),
              title: Text(
                'Customer Feedback',
                style: TextStyle(fontSize: 18, fontFamily: 'QuickSand'),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(FeedbackScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.search,
                size: 28,
              ),
              title: Text(
                'Search Item',
                style: TextStyle(fontSize: 18, fontFamily: 'QuickSand'),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(SearchAppBar.routeName);
              },
            ),
            Divider(),
            ExpansionTile(
              leading: Icon(
                Icons.settings,
                size: 28,
              ),
              title: Text(
                'Settings',
                style: TextStyle(fontSize: 18, fontFamily: 'QuickSand'),
              ),
              children: [
                ListTile(
                  leading: Icon(
                    Icons.info_outline,
                    size: 28,
                  ),
                  title: Text(
                    'About App',
                    style: TextStyle(fontSize: 18, fontFamily: 'QuickSand'),
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(AboutScreen.routeName);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.app_settings_alt,
                    size: 28,
                  ),
                  title: Text(
                    'App Settings',
                    style: TextStyle(fontSize: 18, fontFamily: 'QuickSand'),
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(Settings.routeName);
                  },
                ),
              ],
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.contact_page,
                size: 28,
              ),
              title: Text(
                'Contact us',
                style: TextStyle(fontSize: 18, fontFamily: 'QuickSand'),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(LaunchUrlDemo.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.chat_rounded,
                size: 28,
              ),
              title: Text(
                'Shopify Assistant',
                style: TextStyle(fontSize: 18, fontFamily: 'QuickSand'),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(FlutterFactsChatBot.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                size: 28,
              ),
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 18, fontFamily: 'QuickSand'),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/');
                Provider.of<Auth>(context, listen: false).logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
