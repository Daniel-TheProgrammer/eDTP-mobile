import 'package:shopify/providers/accounts.dart';
import 'package:shopify/providers/product.dart';
import 'package:shopify/screens/about.dart';
import 'package:shopify/screens/account_details.dart';
import 'package:shopify/screens/chatbot.dart';
import 'package:shopify/screens/payments.dart';
import 'package:shopify/widgets/feedback.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/search.dart';
import 'package:flutter/material.dart';
import './screens/splash_screen.dart';
import './screens/cart_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/auth.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';
import './helpers/custom_route.dart';
import './widgets/feedback.dart';
import './screens/account_details.dart';
import './providers/accounts.dart';
import './screens/about.dart';
import './screens/launchURL.dart';
import './screens/payments.dart';
import './screens/settings.dart';
import './screens/chatbot.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        // ignore: missing_required_param
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (ctx, auth, previousProducts) => Products(
            auth.token,
            auth.userId,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        // ignore: missing_required_param
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (ctx, auth, previousOrders) => Orders(
            auth.token,
            auth.userId,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          darkTheme: ThemeData(
            brightness: Brightness.dark,
          ),
          debugShowCheckedModeBanner: false,
          title: 'Shopify',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primarySwatch: Colors.cyan,
            accentColor: Colors.pink,
            fontFamily: 'OpenSans-Bold',
            pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CustomPageTransitionBuilder(),
                TargetPlatform.iOS: CustomPageTransitionBuilder(),
              },
            ),
          ),
          home: auth.isAuth
              ? ProductsOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
            FeedbackScreen.routeName: (ctx) => FeedbackScreen(),
            AccountDetailScreen.routeName: (ctx) => AccountDetailScreen(),
            SearchAppBar.routeName: (ctx) => SearchAppBar(),
            AboutScreen.routeName: (ctx) => AboutScreen(),
            LaunchUrlDemo.routeName: (ctx) => LaunchUrlDemo(),
            Payment.routeName: (ctx) => Payment(),
            Settings.routeName: (ctx) => Settings(),
            FlutterFactsChatBot.routeName: (ctx) => FlutterFactsChatBot(),
          },
        ),
      ),
    );
  }
}
