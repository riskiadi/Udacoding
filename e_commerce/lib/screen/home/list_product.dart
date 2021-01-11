import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/repository/network_repo.dart';
import 'package:e_commerce/screen/dashboard_home.dart';
import 'package:e_commerce/screen/home/detail_product_page.dart';
import 'package:e_commerce/utils/constant.dart';
import 'package:flutter/material.dart';

class ListProductPage extends StatefulWidget {
  String category;
  ListProductPage({this.category});

  @override
  _ListProductPageState createState() => _ListProductPageState();
}

class _ListProductPageState extends State<ListProductPage> {
  List<DataProduct> listProduct = [];

  getData() async {
    var result;
    if (widget.category != "2" || widget.category != "3") {
      print("Masuk Sini 1");
      result = await networkRepo.getProduct();
    } else {
      print("Masuk Sini 2");
      result = await networkRepo.getProdCategory(widget.category);
    }
    setState(() {
      listProduct = result;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        title: Text("List Product", style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
      ),
      body: listProduct == null
          ? Center(child: Text("Data Kosong"))
          : listProduct.length == 0
              ? Center(child: CircularProgressIndicator())
              : Container(
                  margin: EdgeInsets.all(8),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.7,
                    ),
                    shrinkWrap: true,
                    itemCount: listProduct.length,
                    itemBuilder: (BuildContext context, int index) {
                      DataProduct data = listProduct[index];
                      return InkWell(
                        onTap: () async {
                          var result = await goTo(
                              context, DetailProductPage(dataProduct: data));
                          if (result != null) {
                            setState(() {
                              currentIndex = result;
                              tabController.animateTo(result);
                            });
                          }
                        },
                        child: Container(
                          width: 150,
                          child: Card(
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Stack(
                                  children: <Widget>[
                                    ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(4),
                                            topRight: Radius.circular(4)),
                                        child: Image.network(
                                          imageUrl +
                                              "${data?.produkGambar ?? ""}",
                                          fit: BoxFit.fill,
                                          height: 120,
                                          width: double.infinity,
                                        )),
                                    Container(
                                      height: 40,
                                      width: 40,
                                      margin: EdgeInsets.all(4),
                                      alignment: Alignment.center,
                                      child: Text("20%",
                                          style:
                                              TextStyle(color: Colors.white)),
                                      decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.8),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 4),
                                        margin:
                                            EdgeInsets.symmetric(vertical: 4),
                                        child: Text("Daily",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10)),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[500],
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                      ),
                                      Text("${data?.produkNama ?? ""}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600)),
                                      SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                              "Rp.${moneyFormat((data?.produkHarga ?? 0) + 15000)}",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                  decoration: TextDecoration
                                                      .lineThrough)),
                                          Text(
                                              "Rp.${moneyFormat(data?.produkHarga ?? 0)}",
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
