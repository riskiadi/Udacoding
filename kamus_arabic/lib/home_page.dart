import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kamus_arabic/models/dictionary.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Dictionary> _dictionary;
  List<Dictionary> _dictionaryDisplay;

  @override
  void initState() {
    getDictionary().then((value) {
      setState(() {
        _dictionary = value;
        _dictionaryDisplay = _dictionary;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Center(child: Text("Arabic Dictionary")),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 30),
            child: Container(
              padding: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6), color: Colors.white),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Search...",
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(top: 14)),
                maxLines: 1,
                onChanged: (value){
                  value = value.toLowerCase();
                  setState(() {
                    _dictionaryDisplay = _dictionary.where((element){
                      var title = element.indonesia.toLowerCase();
                      return title.contains(value);
                    }).toList();
                  });
                },
              ),
            ),
          ),
          ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: _dictionaryDisplay == null ? 0 : _dictionaryDisplay.length,
            itemBuilder: (context, index) {
              Dictionary dictionary = _dictionaryDisplay[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 30),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white),
                  child: ListTile(
                    visualDensity: VisualDensity.comfortable,
                    title: Text(dictionary.indonesia, style: TextStyle(fontSize: 18),maxLines: 1,overflow: TextOverflow.ellipsis,),
                    subtitle: Text(dictionary.pronounce, style: TextStyle(fontSize: 16),maxLines: 1,overflow: TextOverflow.ellipsis,),
                    trailing: Text(
                      dictionary.arabic,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  static Future<List<Dictionary>> getDictionary() async {
    try {
      final response = await http.get("http://alkalynxt.000webhostapp.com/udacoding_kamus/read/");
      if (response.statusCode == 200) {
        final List<Dictionary> dictionary =
            dictionaryFromJson(utf8.decode(response.bodyBytes));
        return dictionary;
      } else {
        List<Dictionary>();
      }
    } catch (e) {
      return List<Dictionary>();
    }
  }
}
