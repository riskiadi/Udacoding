import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:online_note/pages/alternote_page.dart';
import 'package:online_note/services.dart';
import 'package:online_note/models/note_get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final cSearchField = TextEditingController();
  List<Note> notes;
  List<Note> _notesDisplay;

  @override
  Future<void> initState() {
    Services().fetchNote().then((value) {
      setState(() {
        notes = value.notes;
        _notesDisplay = value.notes;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        splashColor: Colors.black26,
        backgroundColor: Color(0xFFd8d8d8),
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/addnote');
        },
      ),
      backgroundColor: const Color(0xff202125),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22, right: 22, top: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Notes",
                  style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(30),
                      child: Icon(
                        Icons.refresh,
                        color: Colors.white,
                        size: 32,
                      ),
                      onTap: () {
                        toast("Updating...");
                        setState(() {
                          Services().fetchNote().then((value) {
                            setState(() {
                              notes = value.notes;
                              _notesDisplay = value.notes;
                              toast("Notes have been updated");
                            });
                          });
                        });
                      },
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(30),
                      child: Icon(
                        Icons.account_circle,
                        color: Colors.white,
                        size: 32,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/account');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
              decoration: BoxDecoration(
                  color: Color(0xff2E2F33),
                  borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              padding:
                  const EdgeInsets.only(top: 4, bottom: 4, left: 20, right: 20),
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 40),
                    child: TextField(
                      controller: cSearchField,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        hintText: "Search note...",
                        hintStyle: TextStyle(color: Colors.white38),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _notesDisplay = notes.where((element) {
                            var _title = element.title.toLowerCase();
                            var _note = element.note.toLowerCase();
                            return (_title.contains(value.toLowerCase()) ||
                                _note.contains(value.toLowerCase()));
                          }).toList();
                        });
                      },
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.clear,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      if (cSearchField.text.isNotEmpty) {
                        setState(() {
                          cSearchField.clear();
                          _notesDisplay = notes;
                        });
                      }
                    },
                  ),
                ],
              )),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: StaggeredGridView.countBuilder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              itemCount: _notesDisplay == null ? 0 : _notesDisplay.length,
              staggeredTileBuilder: (index) {
                return StaggeredTile.fit(1);
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AlterNotePage(
                        noteId:  _notesDisplay[index].id,
                        title: _notesDisplay[index].title,
                        note: _notesDisplay[index].note,
                        timestamp: _notesDisplay[index].timestamp,
                      ),));
                    },
                    child: Container(
                      padding: EdgeInsets.all(13),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                              color: const Color(0xff606267), width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _notesDisplay[index].title,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            _notesDisplay[index].note,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            maxLines: 11,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          _notesDisplay == null ? Container() : notFoundWidget()
        ],
      ),
    );
  }

  Widget notFoundWidget() {
    if (_notesDisplay.length > 0) {
      return Container();
    } else {
      return Column(
        children: [
          Icon(
            Icons.note,
            color: Colors.white,
            size: 30,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "No Note Found",
            style: TextStyle(color: Colors.white),
          ),
        ],
      );
    }
  }

  toast(String message) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color(0xff6aa0e1),
        textColor: Colors.black,
        fontSize: 16.0);
  }

}
