import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/repository/network_repo.dart';
import 'package:e_commerce/screen/dashboard_home.dart';
import 'package:e_commerce/screen/home/detail_product_page.dart';
import 'package:e_commerce/screen/home/list_product.dart';
import 'package:e_commerce/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DataProduct> listDailyCat = [];
  List<DataProduct> listVegetableCat = [];
  List<DataProduct> listFruitCat = [];
  List<DataProduct> listProduct = [];
  List listMenu = [
    {"title": "Buah", "image": "fruit.png", "cat": "3"},
    {"title": "Sayur", "image": "vegetable.png", "cat": "2"},
    {"title": "Kacang", "image": "bean.png", "cat": "4"},
    {"title": "Jamur", "image": "mushroom.png", "cat": "4"},
    {"title": "Ikan", "image": "fish.png", "cat": "4"},
    {"title": "Telur", "image": "egg.png", "cat": "4"},
    {"title": "Daging", "image": "meat.png", "cat": "4"},
    {"title": "Susu", "image": "milk.png", "cat": "4"},
  ];

  getProduct() async {
    var resDaily = await networkRepo.getProdCategory(dailyCat);
    var resVegetable = await networkRepo.getProdCategory(vegetableCat);
    var resFruit = await networkRepo.getProdCategory(fruitCat);
    var resProduct = await networkRepo.getProduct();
    if (this.mounted) {
      setState(() {
        if (resDaily != null) {
          listDailyCat = resDaily;
        }
        if (listVegetableCat != null) {
          listVegetableCat = resVegetable;
        }
        if (listFruitCat != null) {
          listFruitCat = resFruit;
        }
        if (listProduct != null) {
          listProduct = resProduct;
        }
      });
      deleteData();
    }
  }

  deleteData() async {
    setState(() {
      if (listDailyCat.length > 5) {
        listDailyCat.removeRange(5, listDailyCat.length);
      }
      if (listVegetableCat.length > 5) {
        listVegetableCat.removeRange(5, listVegetableCat.length);
      }
      if (listFruitCat.length > 5) {
        listFruitCat.removeRange(5, listFruitCat.length);
      }
      if (listProduct.length > 5) {
        listProduct.removeRange(5, listProduct.length);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8)),
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    child: FlatButton.icon(
                      icon: Icon(Icons.search, color: baseColor, size: 20),
                      label: Text("Cari product segar disini...",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                      onPressed: () {},
                    ),
                  ),
                ),
                CarouselSlider.builder(
                  itemCount: listProduct?.length ?? 0,
                  options: CarouselOptions(
                    height: 150,
                    autoPlay: true,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    DataProduct data;
                    if (listProduct != null && listProduct?.length != 0) {
                      data = listProduct[index];
                    }
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
                        width: double.infinity,
                        height: double.infinity,
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(blurRadius: 5, color: Colors.grey)
                            ],
                            image: data?.produkGambar == null
                                ? null
                                : DecorationImage(
                                    image: NetworkImage(
                                        imageUrl + (data?.produkGambar ?? "")),
                                    fit: BoxFit.fill)),
                      ),
                    );
                  },
                ),

                // Menu Grid
                Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.only(top: 24),
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: GridView.builder(
                    itemCount: listMenu.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8),
                    itemBuilder: (BuildContext context, int index) {
                      Map data = listMenu[index];
                      return InkWell(
                        onTap: () {
                          goTo(context, ListProductPage(category: data["cat"]));
                        },
                        child: Container(
                            child: Column(
                          children: <Widget>[
                            Image.asset('images/${data['image']}',
                                height: 35, width: 35, fit: BoxFit.fill),
                            Text("${data['title']}",
                                style: TextStyle(fontWeight: FontWeight.w500))
                          ],
                        )),
                      );
                    },
                  ),
                ),

                // Daily Special
                Divider(thickness: 15, color: Colors.black.withOpacity(0.1)),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Special hari ini",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                Text("Promo menarik dari kami untuk kamu",
                                    style: TextStyle(fontSize: 12)),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text("Lihat semua",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: baseColor)),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 15,
                                  color: baseColor,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      listDailyCat.length == 0
                          ? listLoading()
                          : Container(
                              margin: EdgeInsets.only(top: 16),
                              height: 240,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: listDailyCat.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  DataProduct data = listDailyCat[index];
                                  return InkWell(
                                    onTap: () async {
                                      var result = await goTo(context,
                                          DetailProductPage(dataProduct: data));
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Stack(
                                              children: <Widget>[
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(4),
                                                            topRight:
                                                                Radius.circular(
                                                                    4)),
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
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  decoration: BoxDecoration(
                                                      color: Colors.red
                                                          .withOpacity(0.8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100)),
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
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 16,
                                                            vertical: 4),
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4),
                                                    child: Text("Daily",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10)),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[500],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100)),
                                                  ),
                                                  Text(
                                                      "${data?.produkNama ?? ""}",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                  SizedBox(height: 16),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Text(
                                                          "Rp.${moneyFormat((data?.produkHarga ?? 0) + 15000)}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough)),
                                                      Text(
                                                          "Rp.${moneyFormat(data?.produkHarga ?? 0)}",
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                    ],
                  ),
                ),

                // Sayuran Segar
                Divider(thickness: 15, color: Colors.black.withOpacity(0.1)),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Sayuran segar",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                Text("Kumpulan sayuran segar",
                                    style: TextStyle(fontSize: 12)),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text("Lihat semua",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: baseColor)),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 15,
                                  color: baseColor,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      listVegetableCat?.length == 0
                          ? listLoading()
                          : Container(
                              margin: EdgeInsets.only(top: 16),
                              height: 240,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: listVegetableCat?.length ?? 0,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  DataProduct data = listVegetableCat[index];
                                  return InkWell(
                                    onTap: () async {
                                      var result = await goTo(context,
                                          DetailProductPage(dataProduct: data));
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Stack(
                                              children: <Widget>[
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(4),
                                                            topRight:
                                                                Radius.circular(
                                                                    4)),
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
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  decoration: BoxDecoration(
                                                      color: Colors.red
                                                          .withOpacity(0.8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100)),
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
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 16,
                                                            vertical: 4),
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4),
                                                    child: Text("Vegetable",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10)),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[500],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100)),
                                                  ),
                                                  Text(
                                                      "${data?.produkNama ?? ""}",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                  SizedBox(height: 16),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Text(
                                                          "Rp.${moneyFormat((data?.produkHarga ?? 0) + 15000)}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough)),
                                                      Text(
                                                          "Rp.${moneyFormat(data?.produkHarga ?? 0)}",
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                    ],
                  ),
                ),

                // Masakan sehat
                Divider(thickness: 15, color: Colors.black.withOpacity(0.1)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 16),
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Masak masakan sehat yuk",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700)),
                          Text("Bikin yoghurt bar yang sehat dan enak nih",
                              style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                              image: NetworkImage(dummyImage),
                              fit: BoxFit.cover)),
                    ),
                  ],
                ),

                // Buah Segar
                Divider(thickness: 15, color: Colors.black.withOpacity(0.1)),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Buah segar",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                Text("Kumpulan buah segar",
                                    style: TextStyle(fontSize: 12)),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text("Lihat semua",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: baseColor)),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 15,
                                  color: baseColor,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 16),
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              image: DecorationImage(
                                  image: NetworkImage(dummyImage),
                                  fit: BoxFit.cover))),
                      (listFruitCat?.length ?? 0) == 0
                          ? listLoading()
                          : Container(
                              margin: EdgeInsets.only(top: 24),
                              height: 240,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: listFruitCat?.length ?? 0,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  DataProduct data = listFruitCat[index];
                                  return InkWell(
                                    onTap: () async {
                                      var result = await goTo(context,
                                          DetailProductPage(dataProduct: data));
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Stack(
                                              children: <Widget>[
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(4),
                                                            topRight:
                                                                Radius.circular(
                                                                    4)),
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
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  decoration: BoxDecoration(
                                                      color: Colors.red
                                                          .withOpacity(0.8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100)),
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
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 16,
                                                            vertical: 4),
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4),
                                                    child: Text("Fruits",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10)),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[500],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100)),
                                                  ),
                                                  Text(
                                                      "${data?.produkNama ?? ""}",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                  SizedBox(height: 16),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Text(
                                                          "Rp.${moneyFormat((data?.produkHarga ?? 0) + 15000)}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough)),
                                                      Text(
                                                          "Rp.${moneyFormat(data?.produkHarga ?? 0)}",
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
