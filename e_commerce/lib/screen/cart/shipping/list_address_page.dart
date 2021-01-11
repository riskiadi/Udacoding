import 'package:e_commerce/model/shipping_model.dart';
import 'package:e_commerce/repository/network_repo.dart';
import 'package:e_commerce/screen/cart/shipping/add_shipping_page.dart';
import 'package:e_commerce/utils/constant.dart';
import 'package:flutter/material.dart';

class ListAddressPage extends StatefulWidget {
  Shipping defShipping;
  ListAddressPage({this.defShipping});
  @override
  _ListAddressPageState createState() => _ListAddressPageState();
}

class _ListAddressPageState extends State<ListAddressPage> {
  Shipping valShipping;
  List<Shipping> listShipping = [];

  void getShippingAddr() async {
    var result = await networkRepo.getShipping();
    setState(() {
      if (result != null) {
        listShipping = result;
        listShipping.sort((a, b) => a.title.compareTo(b.title));
        setDefaultAddress();
      }
    });
  }

  void setDefaultAddress() {
    valShipping =
        listShipping.where((e) => e.id == widget.defShipping.id)?.toList()[0];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getShippingAddr();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, valShipping);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black87),
          title: Text("Alamat Pengiriman",
              style: TextStyle(color: Colors.black87)),
          backgroundColor: Colors.white,
        ),
        body: Container(
          margin: EdgeInsets.all(8),
          child: listShipping.length == 0
              ? Center(child: Text("Data Kosong"))
              : ListView.builder(
                  itemCount: listShipping.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    Shipping data = listShipping[index];
                    return Card(
                      elevation: 5,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("${data?.title ?? ""}",
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w700)),
                                      SizedBox(height: 8),
                                      Text("Province : ${data?.province ?? ""}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500)),
                                      SizedBox(height: 2),
                                      Text("City: ${data?.city ?? ""}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500)),
                                      SizedBox(height: 2),
                                      Text(
                                          "Alamat: ${data?.address ?? ""}, ${data?.zipCode ?? ""}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                                Radio(
                                  groupValue: valShipping,
                                  value: listShipping[index],
                                  onChanged: (Shipping value) {
                                    setState(() {
                                      valShipping = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Divider(thickness: 1),
                          Container(
                              height: 25,
                              width: double.infinity,
                              margin: EdgeInsets.only(bottom: 16, top: 8),
                              child: FlatButton(
                                textColor: Colors.black54,
                                child: Text("Edit Alamat"),
                                onPressed: () async {
                                  await goTo(
                                      context,
                                      AddShippingPage(
                                        dataShipping: data,
                                        status: "update",
                                      )).then((value) async {
                                    var result =
                                        await networkRepo.getShipping();
                                    setState(() {
                                      if (result != null) {
                                        listShipping = result;
                                      }
                                    });
                                  });
                                },
                              ))
                        ],
                      ),
                    );
                  },
                ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 5)]),
          child: BottomAppBar(
            elevation: 5,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              height: 40,
              width: double.infinity,
              child: RaisedButton(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                color: baseColor,
                child: Text(
                  "Tambah Address",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  goTo(context, AddShippingPage()).then((value) async {
                    var result = await networkRepo.getShipping();
                    setState(() {
                      if (result != null) {
                        listShipping = result;
                      }
                    });
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
