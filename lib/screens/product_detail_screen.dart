import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;
  // final double price;

  // ProductDetailScreen(this.title, this.price);
  static const routeName = '/product-detail';
  final databaseRef = FirebaseDatabase.instance.reference();
//database reference object
  // final textcontroller = TextEditingController();
  void addData(String data) {
    databaseRef.push().set({'name': data, 'comment': 'A good season'});
  }

  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context).settings.arguments as String; // is the id!
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(loadedProduct.title),
      // ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                loadedProduct.title,
                textAlign: TextAlign.start,
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.cyan,
                    color: Colors.black),
                //softWrap: true,
              ),
              background: Hero(
                tag: loadedProduct.id,
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10),
                Text(
                  '\u20B9${loadedProduct.price}',
                  style: TextStyle(
                    color: Colors.cyan,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: Text(
                    loadedProduct.description,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Raleway',
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Container(
                  width: 100,
                  height: 70,
                  padding: const EdgeInsets.fromLTRB(70, 10, 70, 10),
                  child: RaisedButton(
                    splashColor: Colors.white,
                    color: Colors.cyan[200],
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 15,
                        ),
                        Center(child: Icon(Icons.rate_review, size: 28)),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Add Review!",
                          style: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          softWrap: true,
                        )
                      ],
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'Add Review',
                                style: TextStyle(
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold),
                              ),
                              content: TextField(
                                //  controller: textcontroller,
                                maxLines: 2,
                                style: TextStyle(
                                    fontFamily: 'Raleway', fontSize: 17),
                                decoration: InputDecoration(
                                    hintText: 'Share your experience'),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  color: Colors.cyan[200],
                                  textColor: Colors.black,
                                  child: Text('Add'),
                                  onPressed: () => [
                                    //  addData(textcontroller.text),
                                    Navigator.of(context).pop(),
                                  ],
                                  //
                                ),
                              ],
                            );
                          });
                    },
                  ),
                ),
                Center(
                  child: RatingBar.builder(
                    initialRating: 2,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ),
                SizedBox(
                  height: 600,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
