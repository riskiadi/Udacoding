import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:simple_ecomerce/const/custom_color.dart';
import 'package:simple_ecomerce/models/fetch_all.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  final int index;

  ProductDetailPage({
    Key key,
    this.product,
    this.index,
  }) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF4F5F5),
      appBar: AppBar(
        title: Text(widget.product.productName),
        elevation: 0,
        backgroundColor: CustomColor.red,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: widget.index,
                      child: Image(
                        image: NetworkImage(widget.product.productImage),
                        height: 400,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(widget.product.productName.trim(),style: TextStyle(fontSize: 19),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        FlutterMoneyFormatter(
                            amount: (double.parse(widget.product.productPrice)),
                            settings: MoneyFormatterSettings(
                                symbol: 'Rp',
                                thousandSeparator: '.',
                                fractionDigits: 0))
                            .output
                            .symbolOnLeft,
                        style: TextStyle(fontSize: 21, color: CustomColor.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Text("Product Description",style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(widget.product.productDescription,
                        style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.7)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 90,),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(19),
              child: Material(
                elevation: 14,
                color: Colors.transparent,
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                    color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Material(
                          color: Colors.white,
                          child: InkWell(
                              child: Container(padding: const EdgeInsets.all(10),child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Feather.heart, size: 18,),SizedBox(width: 10,),Text('Favorite',style: TextStyle(fontSize: 18),)],)),
                              onTap: (){}
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Material(
                          color: Colors.white,
                          child: InkWell(
                              child: Container(padding: const EdgeInsets.all(10),child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Feather.shopping_cart, size: 18,),SizedBox(width: 10,),Text('Add to Cart',style: TextStyle(fontSize: 18),)],)),
                              onTap: (){}
                          ),
                        ),
                      ),
                    ],
                  )
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
