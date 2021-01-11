import 'package:e_commerce/model/keranjang_model.dart';
import 'package:e_commerce/repository/network_repo.dart';
import 'package:e_commerce/screen/cart/checkout_page.dart';
import 'package:e_commerce/screen/dashboard_home.dart';
import 'package:e_commerce/utils/constant.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  List<DataKeranjang> listKeranjang = [];

  getKeranjang() async {
    var listTemp = await networkRepo.getKeranjang();
    if (this.mounted) {
      setState(() {
        listKeranjang = listTemp;
      });
    }
  }

  int getGrandTotal(){
    int totalHarga = 0;
    if(listKeranjang!=null){
      listKeranjang.forEach((DataKeranjang dataKeranjang) {
        totalHarga+=dataKeranjang.detailTotal;
      });
    }
    return totalHarga;
  }

  @override
  void initState() {
    super.initState();
    getKeranjang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Keranjang", style: TextStyle(color: Colors.black87)),
      ),
      body: Container(
        child: listKeranjang == null
            ? Center(child: Text("Data Kosong"))
            : listKeranjang.length == 0
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: listKeranjang?.length ?? 0,
                    itemBuilder: (context, index) {
                      DataKeranjang data = listKeranjang[index];
                      listKeranjang[index].detailTotal = data.detailTotal;
                      return Container(
                        child: ListTile(
                          leading: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [BoxShadow(blurRadius: 0.5)],
                              image: DecorationImage(
                                  image: NetworkImage(
                                      imageUrl + (data?.produkGambar)),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          title: Text(data?.produkNama ?? "",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600)),
                          subtitle: Text(moneyFormat(data?.detailTotal,type: TypeMonFormat.Decimal),
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  if (data.detailQty != 1) {
                                    setState(() {
                                      data?.detailQty -= 1;
                                      data?.detailTotal -= data?.detailHarga;
                                    });
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.all(8),
                                  child: Icon(Icons.remove, size: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: data?.detailQty<=1 ? Colors.grey[400] : Colors.lightBlue[100],
                                  ),
                                ),
                              ),
                              Text("${data?.detailQty}"),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    data?.detailQty += 1;
                                    data?.detailTotal += data?.detailHarga;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.all(8),
                                  child: Icon(Icons.add, size: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.lightBlue[100],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 5)]),
        child: BottomAppBar(
          elevation: 5,
          child: Row(
            children: <Widget>[
              Flexible(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Total Belanja",
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                              fontSize: 12)),
                      Text("${moneyFormat(getGrandTotal(),type: TypeMonFormat.Decimal)}",
                          style: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                              fontSize: 16))
                    ],
                  ),
                ),
              ),
              Flexible(
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
                      "Beli",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: listKeranjang == null
                        ? null
                        : () async {
                            progressDialog(context);
                            listKeranjang.forEach((e) async {
                              await networkRepo.updateQty(
                                  e.detailQty, e.detailTotal, e.detailId);
                            });
                            Navigator.pop(context);
                            var res = await goTo(context, CheckoutPage());
                            setState(() {
                              if (res != null) {
                                listKeranjang = [];
                                getKeranjang();
                                currentIndex = res;
                                tabController.animateTo(res);
                              }
                            });
                          },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
