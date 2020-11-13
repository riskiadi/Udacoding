import 'package:absent_udacoding/DashboardAbsen.dart';
import 'package:absent_udacoding/ui_page/profile/ProfilePage.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          DashboardAbsen(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.white,
        child: TabBar(
          controller: controller,
          tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.home,
                color: Colors.green,
              ),
            ),
            Tab(
              child: Icon(
                Icons.person,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
