import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../providers/account.dart';
import '../providers/accounts.dart';
import '../widgets/adaptive_flat_button.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AccountDetailScreen(),
    );
  }
}

class AccountDetailScreen extends StatefulWidget {
  static const routeName = '/account-details';
  @override
  _AccountDetailScreenState createState() => _AccountDetailScreenState();
}

class _AccountDetailScreenState extends State<AccountDetailScreen> {
  LocationData _currentPosition;
  String _address, _dateTime;
  Location location = Location();

  final _nameFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _dateofbirthFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  DateTime _selectedDate;

  var _editedAccountDetail = Account(
    id: null,
    name: '',
    phonenumber: 0,
    address: '',
    dateofbirth: DateTime.now(),
  );
  var _initValues = {
    'name': '',
    'phonenmuber': '',
    'address': '',
    'dateofbirth': '',
  };
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final userId = ModalRoute.of(context).settings.arguments as String;
      if (userId != null) {
        _editedAccountDetail =
            Provider.of<Account>(context, listen: false).findById(userId);
        _initValues = {
          'name': _editedAccountDetail.name,
          'phonenumber': _editedAccountDetail.phonenumber.toString(),
          'address': _editedAccountDetail.address,
          'dateofbirth': _editedAccountDetail.dateofbirth.toIso8601String(),
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (isValid) {
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.TOPSLIDE,
        //headerAnimationLoop: false,
        title: 'Thank you!',
        desc: 'Your details have been updated successfully.',
        btnOkOnPress: () {
          Navigator.of(context).pushReplacementNamed('/');
        },
        btnOkColor: Colors.green,
        btnOkIcon: Icons.check_circle,
      ).show();
    } else {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedAccountDetail.id != null) {
      await Provider.of<Accounts>(context, listen: false)
          .updateAccountDetails(_editedAccountDetail.id, _editedAccountDetail);
    } else {
      try {
        await Provider.of<Accounts>(context, listen: false)
            .addAccountDetails(_editedAccountDetail);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occurred!'),
            content: Text('Something went wrong.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1960),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account Details',
          style: TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.cyan[700], Colors.cyan[200]])),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      initialValue: _initValues['name'],
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Raleway',
                          fontSize: 16,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan)),
                        border: OutlineInputBorder(borderSide: BorderSide()),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_nameFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedAccountDetail = Account(
                          name: _editedAccountDetail.name,
                          phonenumber: double.parse(value),
                          address: _editedAccountDetail.address,
                          dateofbirth: _editedAccountDetail.dateofbirth,
                          id: _editedAccountDetail.id,
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLength: 10,
                      initialValue: _initValues['phonenumber'],
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Raleway',
                          fontSize: 16,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan)),
                        border: OutlineInputBorder(borderSide: BorderSide()),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      focusNode: _phoneFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_addressFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number.';
                        }
                        if (value.length != 10) {
                          return 'Phone Number is invalid';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedAccountDetail = Account(
                          name: _editedAccountDetail.name,
                          phonenumber: double.parse(value),
                          address: _editedAccountDetail.address,
                          dateofbirth: _editedAccountDetail.dateofbirth,
                          id: _editedAccountDetail.id,
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 60,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                                _selectedDate == null
                                    ? 'Pick your Date of Birth!'
                                    : 'Date of Birth: ${DateFormat.yMd().format(_selectedDate)}',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: 'Raleway',
                                  fontSize: 16,
                                )),
                          ),
                          AdaptiveFlatButton('Choose Date', _presentDatePicker)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: _initValues['address'],
                      decoration: InputDecoration(
                        labelText: 'Address',
                        labelStyle: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Raleway',
                          fontSize: 16,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan)),
                        border: OutlineInputBorder(borderSide: BorderSide()),
                      ),
                      maxLines: 3,
                      keyboardType: TextInputType.streetAddress,
                      focusNode: _addressFocusNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedAccountDetail = Account(
                          name: _editedAccountDetail.name,
                          phonenumber: double.parse(value),
                          address: _editedAccountDetail.address,
                          dateofbirth: _editedAccountDetail.dateofbirth,
                          id: _editedAccountDetail.id,
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 400,
                      height: 70,
                      padding: const EdgeInsets.all(10),
                      child: RaisedButton(
                        splashColor: Colors.white,
                        color: Colors.cyan[200],
                        child: Row(
                          children: <Widget>[
                            Text(
                              "\t\t\t\t",
                            ),
                            Center(child: Icon(Icons.place, size: 30)),
                            Text(
                              "\t\tTrack my current Location",
                              style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                              softWrap: true,
                            )
                          ],
                        ),
                        onPressed: () {
                          setState(() {
                            getLoc();
                          });
                        },
                      ),
                    ),
                    Card(
                      elevation: 0,
                      color: Colors.cyan[50],
                      child: Container(
                        padding: EdgeInsets.all(30),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 3,
                              ),
                              if (_dateTime != null)
                                Text(
                                  "Date/Time: $_dateTime",
                                  style: TextStyle(
                                    fontFamily: 'Raleway',
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              SizedBox(
                                height: 3,
                              ),
                              if (_currentPosition != null)
                                Text(
                                  "Latitude: ${_currentPosition.latitude}, Longitude: ${_currentPosition.longitude}",
                                  style: TextStyle(
                                    fontFamily: 'Raleway',
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              SizedBox(
                                height: 3,
                              ),
                              if (_address != null)
                                Text(
                                  "Address: $_address",
                                  style: TextStyle(
                                    fontFamily: 'Raleway',
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              SizedBox(
                                height: 3,
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
    );
  }

  getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();

    DateTime now = DateTime.now();
    _dateTime = DateFormat('EEE d MMM kk:mm:ss ').format(now);
    _getAddress(_currentPosition.latitude, _currentPosition.longitude)
        .then((value) {
      setState(() {
        _address = "${value.first.addressLine}";
      });
    });
  }

  Future<List<Address>> _getAddress(double lat, double lang) async {
    final coordinates = new Coordinates(lat, lang);
    List<Address> add =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return add;
  }
}
