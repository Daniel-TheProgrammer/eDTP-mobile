import 'package:flutter/material.dart';
import 'app_drawer.dart';
import '../screens/products_overview_screen.dart';

class SearchAppBar extends StatelessWidget {
  static const routeName = '/search';
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Shopify',
            style:
                TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.bold),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Colors.cyan[700], Colors.cyan[200]])),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                showSearch(context: context, delegate: ProductSearch());
              },
            )
          ],
          backgroundColor: Colors.cyan,
        ),
        drawer: AppDrawer(),
        body: Center(
          child: ListTile(
            contentPadding: EdgeInsets.fromLTRB(35, 10, 42, 10),
            leading: Icon(
              Icons.search,
              size: 40,
            ),
            title: Text(
              'Search Product!',
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontFamily: 'Raleway'),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
}

class ProductSearch extends SearchDelegate<String> {
  final products = [
    'Red Heels',
    'Heels',
    'Red TShirt',
    'TShirt',
    'Hat',
    'Pearl Earrings',
    'Smart Watch',
    'Watch',
    'Necklace',
    'Earrings',
    'Accessories',
    'Sunglasses',
    'Tshirt',
    'Black and White',
    'Handbag',
    'Embroidered Handbag',
    'Black and White Handbag',
    'Shoes',
    'Converse Shoes',
    'DC and Marvel print',
    'Lipstick',
    'Reddish Pink Lipstick',
    'Bangle Bracelet',
    'Pink Bangle Bracelet',
    'Bracelet',
    'Nailpaint',
    'Pastel Nailpaint',
    'Headphones',
    'Beanie',
    'Blue and White striped Beanie',
    'Pearl Ring',
    'Ring',
    'Silver White Pearl Ring',
    'Parrot Green Gloves',
    'Gloves',
    'Winter Gloves',
    'Leather Wallet',
    'Brown Leather Wallet',
    'Wallet',
    'Red Bow Tie',
    'Bow Tie',
    'Piggy Bank',
    'Pink Piggy Bank',
    'Umbrella',
    'Yellow Umbrella',
    'Bulb',
  ];
  final selectedproducts = [
    'Red Shirt',
    'Red Heels',
    'Hat',
    'Smart Watch',
    'Necklace',
    'Earrings'
  ];

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
              showSuggestions(context);
            }
          },
        )
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(24, 10, 36, 10),
              leading: Icon(
                Icons.mood_bad_outlined,
                size: 50,
              ),
              title: Text(
                'No such product found!',
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    fontFamily: 'Raleway'),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? selectedproducts
        : products.where((product) {
            final productLower = product.toLowerCase();
            final queryLower = query.toLowerCase();

            return productLower.startsWith(queryLower);
          }).toList();

    return buildSuggestionsSuccess(suggestions);
  }

  Widget buildSuggestionsSuccess(List<String> suggestions) => ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          final queryText = suggestion.substring(0, query.length);
          final remainingText = suggestion.substring(query.length);

          return ListTile(
            onTap: () {
              query = suggestion;
              showResults(context);
              if (query.toString() == suggestion.toString()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ProductsOverviewScreen()),
                );
              }
            },
            leading: Icon(Icons.shopping_bag),
            title: RichText(
              text: TextSpan(
                text: queryText,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: [
                  TextSpan(
                    text: remainingText,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
}
