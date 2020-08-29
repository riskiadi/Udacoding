import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:simple_ecomerce/categories.dart';
import 'package:simple_ecomerce/const/custom_color.dart';
import 'package:simple_ecomerce/models/fetch_all.dart';
import 'package:simple_ecomerce/product_detail.dart';
import 'package:simple_ecomerce/profile.dart';
import 'package:simple_ecomerce/services.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_icons/flutter_icons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var searchController = TextEditingController();

  List<Product> productList;
  List<Category> categoryList;

  bool isLoading=true;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    Services().fetchNote().then((value) {
      productList = value.products;
      categoryList = value.categories;
      if(productList.length>0&&categoryList.length>0){
        isLoading=false;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF4F5F5),
      appBar: AppBar(
        backgroundColor: CustomColor.red,
        elevation: 0,
        title: Text(
          'Toko Merah',
          style: TextStyle(fontSize: 25),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Feather.heart,
                size: 23,
              ),
              onPressed: () {}
          ),
          IconButton(
              icon: Icon(
                Feather.user,
                size: 23,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage(),));
              }
          ),
        ],
      ),
      body: isLoading ? Center(child: CircularProgressIndicator()) : ContentWidget(categoryList: categoryList, productList: productList),
    );
  }
}

class ContentWidget extends StatelessWidget {
  const ContentWidget({
    Key key,
    @required this.categoryList,
    @required this.productList,
  }) : super(key: key);

  final List<Category> categoryList;
  final List<Product> productList;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Categories',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              Text(
                'See More',
                style: TextStyle(
                    color: CustomColor.red,
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
              ),
            ],
          ),
        ),
        SizedBox(height: 6),
        //Categories List
        Container(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: MediaQuery.of(context).size.height / 900
            ),
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: categoryList == null ? 0 : categoryList.length,
            itemBuilder: (_, index) {
              return InkWell(
                splashColor: CustomColor.red,
                highlightColor: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.all(7),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 80,
                        child: Image.network(categoryList[index].categoryImage),
                      ),
                      Text(categoryList[index].categoryName),
                    ],
                  ),
                ),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CategoriesPage(productList: productList, filter: categoryList[index].categoryName,),));
                },
              );
            },
          ),
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All Product',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              Text(
                'See More',
                style: TextStyle(
                    color: CustomColor.red,
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        // Product List
        Container(
          padding: const EdgeInsets.only(right: 10, left: 10, bottom: 20),
          child: StaggeredGridView.countBuilder(
            crossAxisCount: 2,
          staggeredTileBuilder: (index) {
           return  StaggeredTile.fit(1);
          },
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: productList == null ? 0 : productList.length,
            itemBuilder: (_, index) {
              return InkWell(
                onTap:() => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailPage(product: productList[index], index: index,),)),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: index,
                        child: Image(image: NetworkImage(productList[index].productImage), fit: BoxFit.cover,),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          productList[index].productName,
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10,bottom: 20,top: 5),
                        child: Text(
                          FlutterMoneyFormatter(amount: (double.parse(productList[index].productPrice)), settings: MoneyFormatterSettings(symbol: 'Rp', thousandSeparator: '.', fractionDigits: 0)).output.symbolOnLeft,
                          style: TextStyle(color: CustomColor.red, fontSize: 18, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
