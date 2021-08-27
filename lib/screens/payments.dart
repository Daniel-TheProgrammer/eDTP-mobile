import 'package:shopify/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import '../screens/orders_screen.dart';
import '../screens/cart_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
// This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.cyan,
      theme: ThemeData(primaryColor: Colors.cyan),
      debugShowCheckedModeBanner: false,
      home: Payment(),
    );
  }
}

class Payment extends StatefulWidget {
  static const routeName = '/payment';

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  bool _showPassword = false;

  String _bankName;
  String _walletName;

  final _form = GlobalKey<FormState>();
  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (isValid) {
      Navigator.of(context).pushNamed(OrdersScreen.routeName);
    } else
      return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () =>
              Navigator.of(context).pushNamed(CartScreen.routeName),
        ),
        title: Text(
          'Payment',
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
      body: SingleChildScrollView(
        child: new Container(
          padding: new EdgeInsets.all(32.0),
          child: new Center(
            child: new Column(
              children: <Widget>[
                new InkWell(
                  onTap: () => showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Card Details'),
                          content: Form(
                            key: _form,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  //controller: _textFieldController,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.credit_card_rounded,
                                      color: Colors.grey[600],
                                      size: 22,
                                    ),
                                    labelText: 'Card Number',
                                    hintText: "1234 1234 1234 1234",
                                    // errorText: _validate
                                    //     ? 'Value Can\'t Be Empty'
                                    //     : null,
                                  ),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,

                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter your Card number';
                                    }

                                    if (value.length != 16) {
                                      return 'Card Number is invalid';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  //controller: _textFieldController,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.calendar_today,
                                        color: Colors.grey[600],
                                        size: 22,
                                      ),
                                      labelText: 'Expiration date',
                                      hintText: "MM/YYYY"),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.datetime,

                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter card expiration date';
                                    }

                                    return null;
                                  },
                                ),
                                TextFormField(
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  //controller: _textFieldController,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.payments_outlined,
                                        color: Colors.grey[600],
                                        size: 22,
                                      ),
                                      labelText: 'CVC',
                                      hintText: "XXX"),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,

                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter your CVC';
                                    }
                                    if (value.length != 3) {
                                      return 'Please enter valid CVC';
                                    }

                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            RaisedButton(
                              //splashColor: Colors.white,
                              color: Colors.redAccent,
                              child: Row(
                                children: <Widget>[
                                  Center(
                                      child: Icon(
                                    Icons.cancel_outlined,
                                    size: 20,
                                    color: Colors.black,
                                  )),
                                  Text(
                                    "\t\tCancel\t\t",
                                    style: TextStyle(color: Colors.black),
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                  )
                                ],
                              ),
                              onPressed: () {
                                setState(() {
                                  Navigator.pop(context);
                                });
                              },
                            ),
                            RaisedButton(
                              //splashColor: Colors.white,
                              color: Colors.green,
                              child: Row(
                                children: <Widget>[
                                  Center(
                                      child: Icon(
                                    Icons.check_circle_outline,
                                    size: 20,
                                    color: Colors.black,
                                  )),
                                  Text(
                                    "\t\tConfirm Payment\t\t",
                                    style: TextStyle(color: Colors.black),
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                  )
                                ],
                              ),
                              onPressed: () => _saveForm(),
                            ),
                          ],
                        );
                      }),
                  child: Card(
                    color: Colors.cyan[200],
                    elevation: 15,
                    child: new Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      padding: new EdgeInsets.all(10.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.payment,
                            color: Colors.black,
                            size: 35,
                          ),
                          SizedBox(width: 30),
                          Text(
                            "Card Payment",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                new InkWell(
                  onTap: () => showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Netbanking Details'),
                          content: Form(
                            key: _form,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DropdownButtonFormField<String>(
                                  value: _bankName,
                                  items: [
                                    'State Bank',
                                    'HDFC Bank',
                                    'Canara Bank',
                                    'Bank of India',
                                    'ICICI Bank',
                                    'Axis Bank '
                                  ]
                                      .map((label) => DropdownMenuItem(
                                            child: Text(label.toString()),
                                            value: label,
                                          ))
                                      .toList(),
                                  hint: Text('Bank Name'),
                                  onChanged: (value) {
                                    setState(() {
                                      _bankName = null;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.account_balance)),
                                  validator: (value) {
                                    if (_bankName == value) {
                                      return 'Please select your Bank';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  //controller: _textFieldController,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.verified_user_outlined,
                                        color: Colors.grey[600],
                                        size: 22,
                                      ),
                                      labelText: 'User ID',
                                      hintText: "Enter your user ID"),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,

                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter your User ID';
                                    }

                                    return null;
                                  },
                                ),
                                TextFormField(
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  //controller: _textFieldController,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.grey[600],
                                      size: 22,
                                    ),
                                  ),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,

                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    if (value.length < 6) {
                                      return 'Password is invalid';
                                    }

                                    return null;
                                  },
                                  obscureText: !this._showPassword,
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            RaisedButton(
                              //splashColor: Colors.white,
                              color: Colors.redAccent,
                              child: Row(
                                children: <Widget>[
                                  Center(
                                      child: Icon(
                                    Icons.cancel_outlined,
                                    size: 20,
                                    color: Colors.black,
                                  )),
                                  Text(
                                    "\t\tCancel\t\t",
                                    style: TextStyle(color: Colors.black),
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                  )
                                ],
                              ),
                              onPressed: () {
                                setState(() {
                                  Navigator.pop(context);
                                });
                              },
                            ),
                            RaisedButton(
                              //splashColor: Colors.white,
                              color: Colors.green,
                              child: Row(
                                children: <Widget>[
                                  Center(
                                      child: Icon(
                                    Icons.check_circle_outline,
                                    size: 20,
                                    color: Colors.black,
                                  )),
                                  Text(
                                    "\t\tConfirm Payment\t\t",
                                    style: TextStyle(color: Colors.black),
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                  )
                                ],
                              ),
                              onPressed: () => _saveForm(),
                            ),
                          ],
                        );
                      }),
                  child: Card(
                    color: Colors.cyan[200],
                    elevation: 15,
                    child: new Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      padding: new EdgeInsets.all(10.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.account_balance,
                            color: Colors.black,
                            size: 35,
                          ),
                          SizedBox(width: 30),
                          Text(
                            "NetBanking",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                new InkWell(
                  onTap: () => showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Wallet Details'),
                          content: Form(
                            key: _form,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DropdownButtonFormField<String>(
                                  value: _walletName,
                                  items: [
                                    'Google Pay',
                                    'PhonePe',
                                    'BHIM',
                                    'Paytm',
                                    'PayPal'
                                  ]
                                      .map((label) => DropdownMenuItem(
                                            child: Text(label.toString()),
                                            value: label,
                                          ))
                                      .toList(),
                                  hint: Text('Wallet Name'),
                                  onChanged: (value) {
                                    setState(() {
                                      _walletName = null;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons
                                          .account_balance_wallet_rounded)),
                                  validator: (value) {
                                    if (_walletName == value) {
                                      return 'Please select your Wallet';
                                    }

                                    return null;
                                  },
                                ),
                                TextFormField(
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  //controller: _textFieldController,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.phone,
                                      color: Colors.grey[600],
                                      size: 22,
                                    ),
                                    prefixText: '+91',
                                    labelText: 'Phone Number',
                                  ),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,

                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter your Phone number';
                                    }

                                    if (value.length != 10) {
                                      return 'Phone Number is invalid';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  //controller: _textFieldController,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.grey[600],
                                      size: 22,
                                    ),
                                    labelText: 'Password',
                                  ),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,

                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter your password';
                                    }

                                    if (value.length < 6) {
                                      return 'Password is invalid';
                                    }
                                    return null;
                                  },
                                  obscureText: !this._showPassword,
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            RaisedButton(
                              //splashColor: Colors.white,
                              color: Colors.redAccent,
                              child: Row(
                                children: <Widget>[
                                  Center(
                                      child: Icon(
                                    Icons.cancel_outlined,
                                    size: 20,
                                    color: Colors.black,
                                  )),
                                  Text(
                                    "\t\tCancel\t\t",
                                    style: TextStyle(color: Colors.black),
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                  )
                                ],
                              ),
                              onPressed: () {
                                setState(() {
                                  Navigator.pop(context);
                                });
                              },
                            ),
                            RaisedButton(
                              //splashColor: Colors.white,
                              color: Colors.green,
                              child: Row(
                                children: <Widget>[
                                  Center(
                                      child: Icon(
                                    Icons.check_circle_outline,
                                    size: 20,
                                    color: Colors.black,
                                  )),
                                  Text(
                                    "\t\tConfirm Payment\t\t",
                                    style: TextStyle(color: Colors.black),
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                  )
                                ],
                              ),
                              onPressed: () => _saveForm(),
                            ),
                          ],
                        );
                      }),
                  child: Card(
                    color: Colors.cyan[200],
                    elevation: 15,
                    child: new Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      padding: new EdgeInsets.all(10.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.account_balance_wallet,
                            color: Colors.black,
                            size: 35,
                          ),
                          SizedBox(width: 30),
                          Text(
                            "Wallet",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                new InkWell(
                  onTap: () => AwesomeDialog(
                    context: context,
                    dialogType: DialogType.SUCCES,
                    animType: AnimType.TOPSLIDE,
                    //headerAnimationLoop: false,
                    title: 'Thank you!',
                    desc: 'Your product has been ordered',
                    btnOkOnPress: () {
                      Navigator.of(context)
                          .pushReplacementNamed(OrdersScreen.routeName);
                    },
                    btnOkIcon: Icons.check_circle,
                    btnOkColor: Colors.green,
                  ).show(),
                  //                       showDialog(
                  // context: context,
                  // builder: (context) {
                  //   return AlertDialog(
                  //     title: Text(
                  //       'Thank you!',
                  //       style: TextStyle(
                  //           fontFamily: 'Raleway',
                  //           fontWeight: FontWeight.bold),
                  //     ),
                  //     content: Text(
                  //       'Your product has been ordered',
                  //       style:
                  //           TextStyle(fontFamily: 'Raleway', fontSize: 17),
                  //     ),
                  //     actions: <Widget>[
                  //       FlatButton(
                  //         color: Colors.cyan[200],
                  //         textColor: Colors.black,
                  //         child: Text('OKAY'),
                  //         onPressed: () => Navigator.of(context)
                  //             .pushReplacementNamed(OrdersScreen.routeName),
                  //       ),
                  //     ],
                  //   );
                  // }),
                  child: Card(
                    color: Colors.cyan[200],
                    elevation: 15,
                    child: new Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      padding: new EdgeInsets.all(10.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.money,
                            color: Colors.black,
                            size: 35,
                          ),
                          SizedBox(width: 30),
                          Text(
                            "Cash on Delivery",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
