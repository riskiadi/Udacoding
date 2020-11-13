import 'package:absent_udacoding/model/ModelAbsent.dart';
import 'package:absent_udacoding/ui_page/profile/DetailProfile.dart';
import 'package:flutter/material.dart';
import 'network/NetworkProvider.dart';
import 'ui_page/checkin/CheckIn.dart' as tabcheckin;
import 'ui_page/checkout/CheckOut.dart' as tabcheckout;
import 'package:textfield_search/textfield_search.dart';

class DashboardAbsen extends StatefulWidget {
  @override
  _DashboardAbsenState createState() => _DashboardAbsenState();
}

class _DashboardAbsenState extends State<DashboardAbsen> with SingleTickerProviderStateMixin {
  TabController controller;
  TextEditingController _searchController;
  NetworkProvider _networkProvider = NetworkProvider();
  List<String> _searchList=[];
  List<Absent> _profileList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(vsync: this, length: 2);
    _searchController = TextEditingController();
    _networkProvider.getAbsent("").then((List list){
      _profileList = list;
      _profileList.forEach((Absent element) {
        _searchList.add(element.fullnameUser);
      });
    });
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
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              leading: Icon(
                Icons.search,
                color: Colors.black,
              ),
              title: TextFieldSearch(
                label: "",
                decoration: InputDecoration(
                  hintText: 'Search Users',
                ),
                controller: _searchController,
                initialList: _searchList,
              ),
              trailing: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: (){
                    var filtered = _profileList.where((element){
                      return element.fullnameUser.contains(_searchController.text);
                    });
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailProfile(data: filtered.first,),));
                  }
                  ),

              // title: TextField(
              //     decoration: InputDecoration(
              //       hintText: 'Search Users',
              //     ),
              //     onChanged: (text) {
              //       text = text.toLowerCase();
              //       setState(() {});
              //     }),
            ),
          ),
        ),
        bottom: TabBar(
          controller: controller,
          tabs: <Widget>[
            Tab(
              text: 'Check In',
            ),
            Tab(
              text: 'Check Out',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          tabcheckin.CheckIn(controller),
          tabcheckout.CheckOut(),
        ],
      ),
    );
  }
}
