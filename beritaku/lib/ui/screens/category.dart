import 'package:beritaku/model/newsmodel.dart';
import 'package:beritaku/ui/widgets/news_list.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

class CategoryPage extends StatefulWidget {

  final String category;
  final List<NewsModel> newsList;
  const CategoryPage({Key key, @required this.newsList, @required this.category}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category.titleCase),),
      body: NewsList(filterContent(widget.category)),
    );
  }

  List<NewsModel> filterContent(String filterCategory){
    List<NewsModel> filtered = widget.newsList.where((element){
      var filter = element.newsCategory.categoryName.toLowerCase();
      return (filter.contains(filterCategory.toLowerCase()));
    }).toList();
    return filtered;
  }

}
