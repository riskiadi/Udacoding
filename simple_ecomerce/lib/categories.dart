import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:simple_ecomerce/const/custom_color.dart';
import 'package:simple_ecomerce/models/fetch_all.dart';
import 'package:simple_ecomerce/product_detail.dart';

class CategoriesPage extends StatefulWidget {

  final List<Product> productList;
  final String filter;

  CategoriesPage({Key key, this.productList, this.filter}) : super(key: key);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {

  List<Product> _productList;

  @override
  void initState() {
    _productList = widget.productList.where((element){
      return (element.productCategory.contains(widget.filter));
    }).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.filter),backgroundColor: CustomColor.red,),
      body: Container(
        padding: const EdgeInsets.only(right: 10, left: 10, bottom: 20),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: MediaQuery.of(context).size.height / 1070),
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: _productList == null ? 0 : _productList.length,
          itemBuilder: (_, index) {
            return InkWell(
              onTap:() => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailPage(product: _productList[index], index: index,),)),
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(image: NetworkImage(_productList[index].productImage), fit: BoxFit.cover,height: 200,width: 200,)
                    ),
                    SizedBox(height: 10),
                    Text(
                      _productList[index].productName,
                      style: TextStyle(fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(height: 5),
                    Text(
                      FlutterMoneyFormatter(amount: (double.parse(_productList[index].productPrice)), settings: MoneyFormatterSettings(symbol: 'Rp', thousandSeparator: '.', fractionDigits: 0)).output.symbolOnLeft,
                      style: TextStyle(color: CustomColor.red, fontSize: 17),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
