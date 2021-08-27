import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'product.dart';
import 'products.dart';

class Prod {
  static const apiKey = 'AIzaSyDx30gNApdosuoXCRvBiyTM61VvN_ZiHiY';

  static Future<List<String>> searchProduct({@required String query}) async {
    final limit = 3;
    final url =
        'https://yourproject-username-default-rtdb.firebaseio.com/products/?q=$query&limit=$limit&appid=$apiKey';

    final response = await http.get(url);
    final body = json.decode(response.body);

    return body.map<String>((json) {
      final title = json['title'];
      final description = json['description'];

      return '$title, $description';
    }).toList();
  }

  static Future<Product> getProduct({@required String title}) async {
    final url =
        'https://shopify-5113b-default-rtdb.firebaseio.com/?q=$title&appid=$apiKey';

    final response = await http.get(url);
    final body = json.decode(response.body);

    return Product(
        id: '',
        title: '',
        description: '',
        price: null,
        imageUrl: '',
        isFavorite: null);
  }
}
