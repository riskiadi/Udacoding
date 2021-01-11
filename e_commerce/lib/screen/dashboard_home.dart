import 'package:e_commerce/screen/cart/cart_page.dart';
import 'package:e_commerce/screen/history/history_page.dart';
import 'package:e_commerce/screen/home/home_page.dart';
import 'package:e_commerce/screen/profile/profile_page.dart';
import 'package:e_commerce/utils/constant.dart';
import 'package:flutter/material.dart';

int currentIndex = 0;
TabController tabController;

class DashboardHome extends StatefulWidget {
  @override
  _DashboardHomeState createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome>
    with TickerProviderStateMixin {
  List listPage = [
    HomePage(),
    CartPage(),
    HistoryPage(),
    ProfilePage()
  ];

  List<BottomNavigationBarItem> bottomBar = [
    BottomNavigationBarItem(
        icon: Icon(Icons.store_mall_directory), title: Text("Home")),
    BottomNavigationBarItem(
        icon: Icon(Icons.add_shopping_cart), title: Text("Keranjang")),
    BottomNavigationBarItem(icon: Icon(Icons.history), title: Text("History")),
    BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("Profile")),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      tabController = TabController(length: listPage.length, vsync: this);
      currentIndex = 0;
    });
    tabController.addListener(() {
      setState(() => currentIndex = tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
          controller: tabController,
          children: listPage.map((e) => Center(child: e)).toList()),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(blurRadius: 5, color: Colors.grey, spreadRadius: 5),
        ]),
        child: BottomNavigationBar(
          items: bottomBar,
          backgroundColor: baseColor,
          selectedItemColor: baseColor,
          unselectedItemColor: Colors.grey,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              tabController.animateTo(index);
            });
          },
        ),
      ),
    );
  }
}
