import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shopify/screens/auth_screen.dart';
import 'package:shopify/screens/products_overview_screen.dart';
import 'package:shopify/screens/splash_screen.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    // var auth;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FutureBuilder(
          //   future: auth.tryAutoLogin(),
          builder: (ctx, authResultSnapshot) =>
              authResultSnapshot.connectionState == ConnectionState.waiting
                  ? SplashScreen()
                  : AuthScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.all(20),
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      globalHeader: Align(
        alignment: Alignment.topRight,
      ),

      pages: [
        PageViewModel(
          title: "Enjoy Sales and Discounts",
          body: '',
          image: Image.asset('assets/images/onboard1.jpg'),
          decoration: pageDecoration.copyWith(
            imageFlex: 4,
            imageAlignment: Alignment.bottomCenter,
          ),
        ),
        PageViewModel(
          title: "Pay cash or online",
          body: "",
          image: Image.asset('assets/images/onboard2.jpg'),
          decoration: pageDecoration.copyWith(
            imageFlex: 4,
            imageAlignment: Alignment.bottomCenter,
          ),
        ),
        PageViewModel(
          title: "Free Home Delivery",
          body: "",
          image: Image.asset('assets/images/onboard3.jpg'),
          decoration: pageDecoration.copyWith(
            imageFlex: 4,
            imageAlignment: Alignment.bottomCenter,
          ),
          // reverse: true,
        ),
        PageViewModel(
          title: "Shop anytime anywhere",
          body: "",
          image: Image.asset('assets/images/onboard4.jpg'),
          decoration: pageDecoration.copyWith(
            imageFlex: 4,
            imageAlignment: Alignment.bottomCenter,
          ),
          // reverse: true,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: const Text('Skip',
          style: TextStyle(
              color: Color.fromRGBO(0, 76, 153, 1),
              fontWeight: FontWeight.bold,
              fontSize: 18)),
      next: const Icon(
        Icons.arrow_forward,
        color: Color.fromRGBO(0, 76, 153, 1),
      ),
      done: const Text('Login',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 76, 153, 1),
              fontSize: 18)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.grey,
        activeSize: Size(22.0, 10.0),
        activeColor: Color.fromRGBO(0, 76, 153, 1),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
