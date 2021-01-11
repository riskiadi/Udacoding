import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/screen/home/detail_product_page.dart';
import 'package:e_commerce/utils/constant.dart';
import 'package:flutter/material.dart';

class ItemProduct extends StatelessWidget {
  final DataProduct data;
  ItemProduct({this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pop(context);
        goTo(context, DetailProductPage(dataProduct: data));
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
                        imageUrl + "${data?.produkGambar ?? ""}",
                        fit: BoxFit.fill,
                        height: 120,
                        width: double.infinity,
                      )),
                  Container(
                    height: 40,
                    width: 40,
                    margin: EdgeInsets.all(4),
                    alignment: Alignment.center,
                    child: Text("20%", style: TextStyle(color: Colors.white)),
                    decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(100)),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      margin: EdgeInsets.symmetric(vertical: 4),
                      child: Text(statusCat(),
                          style: TextStyle(color: Colors.white, fontSize: 10)),
                      decoration: BoxDecoration(
                          color: Colors.grey[500],
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    Text("${data?.produkNama ?? ""}",
                        style:
                            TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                            "Rp.${moneyFormat((data?.produkHarga??0) + 15000)}",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.lineThrough)),
                        Text("Rp.${moneyFormat(data?.produkHarga??0)}",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.lineThrough)),
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
  }

  String statusCat(){
    String cat = "Daily";
    if(data?.produkKategori == vegetableCat){
      cat = "Vegetable";
    }
    if(data?.produkKategori == fruitCat){
      cat = "Fruit";
    }
    if(data?.produkKategori == otherCat){
      cat = "Other";
    }
    return cat;
  }
}
