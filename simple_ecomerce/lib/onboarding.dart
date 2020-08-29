import 'package:flutter/material.dart';
import 'package:simple_ecomerce/const/custom_color.dart';
import 'package:simple_ecomerce/splash.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColor.red,
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (value) => onChangeFunction(value),
              children: [
                PageOne(),
                PageTwo(),
                PageThree(),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Indicator(
                      currentIndex: currentIndex,
                      position: 0,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Indicator(
                      currentIndex: currentIndex,
                      position: 1,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Indicator(
                      currentIndex: currentIndex,
                      position: 2,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onChangeFunction(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}

class Indicator extends StatelessWidget {
  final int position;
  final int currentIndex;

  Indicator({Key key, this.position, this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        height: 12,
        width: 12,
        decoration: BoxDecoration(
            color: position == currentIndex ? Colors.white : Colors.black45),
      ),
    );
  }
}

class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 120,
          ),
          SizedBox(
            height: 100,
            child: Image.asset('assets/onboarding-cart.png'),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            'Welcome  to  TokoMerah',
            style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontFamily: 'BebasNeue',
                letterSpacing: 4),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Text(
              'Toko Merah provides several import and cheap clothing from various countries.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          SizedBox(
            height: 130,
            child: Image.asset('assets/onboarding-original.png'),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            'Original',
            style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontFamily: 'BebasNeue',
                letterSpacing: 4),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Text(
              'Toko Merah provides some original products from several countries.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class PageThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 140,
          ),
          SizedBox(
            height: 80,
            child: Image.asset('assets/onboarding-bag.png'),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            'Enjoy Shopping',
            style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontFamily: 'BebasNeue',
                letterSpacing: 4),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Text(
              'Get high quality products with low prices.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          MaterialButton(
            color: Colors.white,
            child: Text('START SHOPPING'),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SplashPage(),));
            },
          ),
        ],
      ),
    );
  }
}
