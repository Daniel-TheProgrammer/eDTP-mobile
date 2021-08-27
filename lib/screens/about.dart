import 'package:shopify/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  static const routeName = '/about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About',
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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Center(child: Image.asset('assets/images/shop2.png')),
              SizedBox(height: 10),
              Text(
                'SHOPIFY',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Card(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    ExpansionTile(
                      collapsedBackgroundColor: Colors.cyan[50],
                      leading: Icon(
                        Icons.info_outlined,
                        size: 20,
                      ),
                      title: Text(
                        'About us',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                      children: [
                        ListTile(
                          title: Text(
                            'Shopify is an app where users can search for products, view a complete description of the products and order the products.',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Raleway',
                                color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ExpansionTile(
                      collapsedBackgroundColor: Colors.cyan[50],
                      leading: Icon(
                        Icons.privacy_tip_outlined,
                        size: 20,
                      ),
                      title: Text(
                        'Privacy Policy',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                      children: [
                        ListTile(
                          title: Text(
                            'This statement of privacy (“Privacy Policy”) describes how Shopify Internet Pvt Ltd collect, use, and disclose information pertaining to you- the user obtained via this application.',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Raleway',
                                color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ExpansionTile(
                      collapsedBackgroundColor: Colors.cyan[50],
                      leading: Icon(
                        Icons.ballot_outlined,
                        size: 20,
                      ),
                      title: Text(
                        'Terms & Conditions',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                      children: [
                        ListTile(
                          title: Text(
                            'Following are our terms and conditions for the user: \n 1. Product order cannot be canceled or deleted. \n 2. By using the App and by providing your information, you consent to the collection and use of the information you disclose on the App in accordance with this Privacy Policy.',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Raleway',
                                color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
