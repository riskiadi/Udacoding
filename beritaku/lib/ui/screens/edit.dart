import 'dart:convert';

import 'package:beritaku/model/infomodel.dart';
import 'package:beritaku/ui/widgets/textfieldwidget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get_storage/get_storage.dart';

class EditPage extends StatefulWidget {

  final int newsId;
  final String title;
  final String content;
  final String newsCategory;
  final String imageBanner;

  const EditPage({Key key, this.title, this.content, this.newsCategory, this.imageBanner, @required this.newsId}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {

  final _formKey = GlobalKey<FormState>();
  final cTitle = TextEditingController();
  final cContent = TextEditingController();
  String newsCategory = '';

  List<Category> _categoryList = List();
  int categoryID;

  @override
  void initState() {
    setState(() {
      cTitle.text = widget.title;
      cContent.text = widget.content;
      newsCategory = widget.newsCategory;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit News'),
        actions: [
          FlatButton(
            child: Text('Update', style: TextStyle(color: Colors.white),),
            onPressed: (){
              if(_formKey.currentState.validate() && newsCategory.isNotEmpty){
                editNews();
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFieldWidget(
                textController: cTitle,
                hintText: "News Title",
                obscureText: false,
                prefixIconData: Icons.assignment,
                isAutoValidator: true,
              ),
              TextFieldWidget(
                textController: cContent,
                hintText: "News Content",
                obscureText: false,
                prefixIconData: Icons.edit,
                isAutoValidator: true,
              ),
              DropdownSearch(
                onChanged: (value) {
                  newsCategory = value;
                  categoryID = int.parse(getCategoriesId(value));
                },
                selectedItem: newsCategory==null || newsCategory.isEmpty ? null : newsCategory,
                hint: 'Choose Category',
                showClearButton: true,
                onFind: (text) {
                  return getCategories();
                },
                validator: (value) {
                  if(value == null){
                    return 'required';
                  }else{
                    return null;
                  }
                },
              ),
              SizedBox(height: 20),
              Image.network(widget.imageBanner, height: 120,),

            ],
          ),
        ),
      ),
    );
  }

  editNews() async{

    final dioNetwork = dio.Dio();
    final formData = dio.FormData.fromMap({
      "news_id" : widget.newsId,
      "news_title": cTitle.text,
      "news_content": cContent.text,
      "news_category": getCategoriesId(newsCategory)
    });

    dio.Response response = await dioNetwork.post(
      'https://flutterest.000webhostapp.com/nagari/Api/editNews',
      data: formData,
    );

    print(response.data.toString());

  }

  Future<List<String>> getCategories() async{

    List<String> categories = List();
    final dioNetwork = dio.Dio();
    dio.Response response = await dioNetwork.get('https://flutterest.000webhostapp.com/nagari/Api/getNewsInfo');

    final infoModel = infoModelFromJson(jsonEncode(response.data));
    infoModel.categories.forEach((Category element) {
      categories.add(element.categoryName);
    });
    setState(() {
      _categoryList = infoModel.categories;
    });
    return categories;
  }

  String getCategoriesId(String category){
    var tmpList = _categoryList.where((element){
      var _category = element.categoryName;
      return (_category.contains(category)
      );
    }).toList();
    setState(() {});
    return tmpList.first.categoryId;
  }


}
