import 'package:absent_udacoding/model/HistoryModel.dart';
import 'package:absent_udacoding/network/NetworkProvider.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class History extends StatefulWidget {
  String idUser;
  History({this.idUser});
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {

  BaseEndPoint network = NetworkProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'History',
          style: TextStyle(
              color: Colors.black, fontFamily: 'Roboto', fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
          future: network.getHistory(widget.idUser),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Errorrr"),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<DataHistory> listData = snapshot.data;
              return Container(
                margin: EdgeInsets.all(8),
                child: ListView.builder(
                  itemCount: listData.length,
                  itemBuilder: (BuildContext context, int index) {
                    DataHistory data = listData[index];
                    return Card(
                      elevation: 10,
                      margin: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    'Check In',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    "${formatDate(data?.checkIn, [HH,':', nn, ':',ss, ' - ', d, ' ', M, ' ', yyyy])}" ?? "",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey[500]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    'Check Out',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    "${formatDate(data?.checkOut, [HH,':', nn, ':',ss, ' - ', d, ' ', M, ' ', yyyy])}" ?? "",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey[500]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    'Total',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    children: [
                                      Text(
                                        "${data?.checkOut.subtract(Duration(hours: data?.checkIn.hour, minutes: data?.checkIn.minute)).hour} jam " ?? "",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.grey[500]),
                                      ),
                                      Text(
                                        "${data?.checkOut.subtract(Duration(hours: data?.checkIn.hour, minutes: data?.checkIn.minute)).minute} menit " ?? "",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.grey[500]),
                                      ),
                                      Text(
                                        "${data?.checkOut.subtract(Duration(hours: data?.checkIn.hour, minutes: data?.checkIn.minute)).second} detik" ?? "",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.grey[500]),
                                      ),
                                    ],
                                  )
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
          }),
    );
  }

}
