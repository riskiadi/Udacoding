import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/model/keranjang_model.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/repository/network_repo.dart';
import 'package:e_commerce/screen/home/item_proudct.dart';
import 'package:e_commerce/utils/constant.dart';
import 'package:flutter/material.dart';

class DetailProductPage extends StatefulWidget {
  final DataProduct dataProduct;
  DetailProductPage({this.dataProduct});
  @override
  _DetailProductPageState createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  DataProduct get dataProduct => widget.dataProduct;
  List<DataProduct> listVegetableCat = [];
  getProduct() async {
    var resVegetable =
        await networkRepo.getProdCategory(dataProduct?.produkKategori);
    setState(() {
      if (listVegetableCat != null) {
        listVegetableCat = resVegetable;
        listVegetableCat
            .removeWhere((e) => e.produkId == dataProduct?.produkId);
        if (listVegetableCat.length > 5) {
          listVegetableCat.removeRange(5, listVegetableCat.length);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context)),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context, 1);
                },
              ),

              FutureBuilder(
                future: networkRepo.getKeranjang(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    List<DataKeranjang> dataKeranjang = snapshot.data;
                    return Positioned(
                      right: 10,
                      top: 4,
                      child: Container(
                        width: 15,
                        height: 15,
                        alignment: Alignment.center,
                        child: Text("${dataKeranjang.length}",
                            style: TextStyle(color: Colors.white, fontSize: 10)),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(100)),
                      ),
                    );
                  }else{
                    return Positioned(
                      right: 10,
                      top: 4,
                      child: Container(
                        width: 15,
                        height: 15,
                        alignment: Alignment.center,
                        child: Text("0",
                            style: TextStyle(color: Colors.white, fontSize: 10)),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(100)),
                      ),
                    );
                  }
                },
              ),


            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CarouselSlider.builder(
                itemCount: 5,
                options: CarouselOptions(
                  height: 170,
                  autoPlay: true,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(blurRadius: 3, color: Colors.grey)
                        ],
                        image: DecorationImage(
                            image: NetworkImage(dummyImage), fit: BoxFit.fill)),
                  );
                },
              ),
              Container(
                  margin: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        dataProduct?.produkNama ?? "",
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 16),
                            child: Text("20%",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.red)),
                            decoration: BoxDecoration(
                                color: Colors.red[100],
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.circular(100)),
                          ),
                          Text(
                              "${moneyFormat((dataProduct?.produkHarga ?? 0) + 15000, type: TypeMonFormat.Decimal)}",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.lineThrough))
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      '${moneyFormat(dataProduct?.produkHarga, type: TypeMonFormat.Decimal)} / ',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              TextSpan(
                                  text: '1kg',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              Divider(thickness: 15, color: Colors.black.withOpacity(0.1)),
              Container(
                  margin: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Informasi Barang",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                                child: Text("Stock",
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600))),
                            Flexible(
                                child: Text("> 200",
                                    style: TextStyle(
                                        color: baseColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600))),
                            Flexible(
                                child: Text("Terjual",
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600))),
                            Flexible(
                                child: Text("126",
                                    style: TextStyle(
                                        color: baseColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600))),
                          ],
                        ),
                      ),
                    ],
                  )),
              Divider(thickness: 0.5, color: Colors.black.withOpacity(0.35)),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(dataProduct?.produkNama ?? "",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                          IconButton(
                            icon: Icon(Icons.keyboard_arrow_up),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      Text(dataProduct?.deskripsiProduk ?? "",
                          maxLines: 10,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(color: Colors.black87, fontSize: 12)),
                      SizedBox(height: 16),
                    ],
                  )),
              Divider(thickness: 15, color: Colors.black.withOpacity(0.1)),
              Container(
                margin: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Penjual",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 10, right: 8),
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              image: DecorationImage(
                                  image: NetworkImage(dummySeller)),
                              borderRadius: BorderRadius.circular(100)),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Muhamad Alamsyah",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              Text("Cirebon"),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
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
                              Text("Produk Terkait",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
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
                                return ItemProduct(data: data);
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 5)]),
        child: BottomAppBar(
          elevation: 5,
          child: Row(
            children: <Widget>[
              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(8),
                  child: Icon(Icons.chat, size: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.grey[300],
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  height: 40,
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    color: baseColor,
                    child: Text(
                      "Beli Sekarang",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  progressDialog(context);
                  networkRepo.addCart(dataProduct).then((value) {
                    Navigator.pop(context);
                    setState(() {});
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(8),
                  child: Icon(Icons.add_shopping_cart, size: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.grey[300],
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
