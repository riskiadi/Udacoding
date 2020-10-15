import 'package:beritaku/ui/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {

  final getStorage = GetStorage();
  var _cPageView = PageController();
  int _pageViewIndex=0;

  @override
  void dispose() {
    _cPageView.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      body: Container(
        padding: EdgeInsets.only(top: 80),
        width: double.infinity,
        child: Stack(
          children: [
            PageView(
              controller: _cPageView,
              onPageChanged: (int value){
                setState(() {
                  _pageViewIndex = value;
                });
              },
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/images/newspaper.svg', width: 150,),
                    SizedBox(height: 50),
                    Text('News always up to date!', style: TextStyle(fontSize: 20),)
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/images/target.svg', width: 150,),
                    SizedBox(height: 50),
                    Text('Good quality information', style: TextStyle(fontSize: 20),)
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                        color: Colors.white,
                        onPressed: (){
                          getStorage.write('onBoarding', true);
                          Get.off(LoginPage());
                        },
                        child: Text("Finish")
                    )
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Indicator(_pageViewIndex, 0),
                    Indicator(_pageViewIndex, 1),
                    Indicator(_pageViewIndex, 2),
                  ],
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}

class Indicator extends StatelessWidget {

  int curentIndex;
  int position;

  Indicator(this.curentIndex,this.position);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ClipOval(
          child: Container(
            height: 12,
            width: 12,
            color: curentIndex == position ? Colors.black.withOpacity(0.8): Colors.black.withOpacity(0.1),
          )
      ),
    );
  }
}