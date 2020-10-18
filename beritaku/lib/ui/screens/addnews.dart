import 'dart:convert';
import 'dart:io';
import 'package:beritaku/model/infomodel.dart';
import 'package:beritaku/ui/widgets/news_imagepicker.dart';
import 'package:beritaku/ui/widgets/textfieldwidget.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:get_storage/get_storage.dart';

class AddNewsPage extends StatefulWidget {
  @override
  _AddNewsPageState createState() => _AddNewsPageState();
}

class _AddNewsPageState extends State<AddNewsPage> {
  File _file;
  final _formKey = GlobalKey<FormState>();
  final cTitle = TextEditingController();
  final cContent = TextEditingController();
  String newsCategory = '';

  List<Category> _categoryList = List();
  int categoryID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add News'),
        actions: [
          FlatButton(
            child: Text(
              'Posting',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              if (_formKey.currentState.validate() && newsCategory.isNotEmpty && _file != null) {
                EasyLoading.show();
                addNews().then((value){
                  EasyLoading.dismiss();
                });
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
                selectedItem: newsCategory == null || newsCategory.isEmpty
                    ? null
                    : newsCategory,
                hint: 'Choose Category',
                showClearButton: true,
                onFind: (text) {
                  return getCategories();
                },
                validator: (value) {
                  if (value == null) {
                    return 'required';
                  } else {
                    return null;
                  }
                },
              ),
              NewsImagePicker(
                filePath: (String path) {
                  setState(() {
                    _file = File(path);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addNews() async {
    final dioNetwork = dio.Dio();

    dioNetwork.options.baseUrl =
        'https://flutterest.000webhostapp.com/nagari/Api/addNews';
    dioNetwork.options.headers = {'Content-Type': 'multipart/form-data'};

    dio.FormData formData = dio.FormData.fromMap({
      "news_title": cTitle.text,
      "news_content": cContent.text,
      "news_category": categoryID,
      "news_author": GetStorage().read('sId'),
      "banner": await dio.MultipartFile.fromFile(_file.path)
    });

    dio.Response response = await dioNetwork.post(
      'https://flutterest.000webhostapp.com/nagari/Api/addNews',
      data: formData,
    );

    print(response.data.toString());
    Get.back(result: true);
  }

  Future<List<String>> getCategories() async {
    List<String> categories = List();
    final dioNetwork = dio.Dio();
    dio.Response response = await dioNetwork
        .get('https://flutterest.000webhostapp.com/nagari/Api/getNewsInfo');

    final infoModel = infoModelFromJson(jsonEncode(response.data));
    infoModel.categories.forEach((Category element) {
      categories.add(element.categoryName);
    });
    setState(() {
      _categoryList = infoModel.categories;
    });
    return categories;
  }

  String getCategoriesId(String category) {
    var tmpList = _categoryList.where((element) {
      var _category = element.categoryName;
      return (_category.contains(category));
    }).toList();
    setState(() {});
    return tmpList.first.categoryId;
  }
}
