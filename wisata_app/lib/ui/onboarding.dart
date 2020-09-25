import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata_app/ui/login.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {

  final pageViewController = PageController();
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffB0E2F1),
        body: Stack(
          children: [

            PageView(
              controller: pageViewController,
              onPageChanged: (value) {
                setState(() {
                  pageIndex = value;
                });
              },
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/image/onboard_image1.png', width: 140,height: 140,),
                    SizedBox(height: 30,),
                    Text("Travel Anywhere", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 5),),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/image/onboard_image2.png', width: 140,height: 140,),
                    SizedBox(height: 30,),
                    Text("Provide Travel Destinations", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 5),),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/image/onboard_image3.png', width: 140,height: 140,),
                    SizedBox(height: 30,),
                    Text("Popular Destinations", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 5),),
                  ],
                ),
              ],
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    previousButton(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Indicator(position: 0, index: pageIndex,),
                        Indicator(position: 1, index: pageIndex,),
                        Indicator(position: 2, index: pageIndex,),
                      ],
                    ),

                    pageIndex >= 2 ? finishButton() : nextButton(),

                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  IconButton previousButton() {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: (){
        setState(() {
          if(pageIndex>=1){
            pageIndex--;
            pageViewController.animateToPage(pageIndex, duration: Duration(milliseconds: 500), curve: Curves.easeInQuart);
          }
        });
      },
    );
  }

  IconButton nextButton() {
    return IconButton(
      icon: Icon(Icons.arrow_forward),
      onPressed: () {
        setState(() {
          if (pageIndex <= 1) {
            pageIndex++;
            pageViewController.animateToPage(pageIndex, duration: Duration(milliseconds: 500), curve: Curves.easeInQuart);
          }
        });
      },
    );
  }

  IconButton finishButton() {
    return IconButton(
      icon: Icon(Icons.done),
      onPressed: () {
        _saveFirstOpen().then((value){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
        });
      },
    );
  }

  Future<bool> _saveFirstOpen() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setBool('isOpen', true);
  }

}

class Indicator extends StatelessWidget {

  final int position;
  final int index;

  const Indicator({this.position, this.index});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      child: ClipOval(
        child: Container(
          height: 12,
          width: 12,
          color: position==index? Colors.black : Colors.black.withOpacity(0.3),
        ),
      ),
    );
  }
}
