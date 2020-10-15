import 'package:beritaku/model/infomodel.dart';
import 'package:beritaku/model/newsmodel.dart';
import 'package:beritaku/ui/screens/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NewsTopRated extends StatefulWidget {

  final List<Category> newsInfo;
  final Future<List<NewsModel>> newsList;
  NewsTopRated(this.newsInfo, this.newsList);

  @override
  _NewsTopRatedState createState() => _NewsTopRatedState();
}

class _NewsTopRatedState extends State<NewsTopRated> {

  List<NewsModel> _newsList;

  @override
  void initState() {
    widget.newsList.then((value){
      setState(() {
        _newsList = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 1.4)),
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: widget.newsInfo.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          child: InkWell(
            onTap: () {
              Get.to(CategoryPage(newsList: _newsList, category: widget.newsInfo[index].categoryName,));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/${widget.newsInfo[index].categoryName}.svg',
                  width: 80,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    widget.newsInfo[index].categoryName.toUpperCase(),
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }



}
