import 'package:flutter/material.dart';
import 'package:online_note/services.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:toast/toast.dart';
import 'package:intl/intl.dart';

class AddNotePage extends StatefulWidget {
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  var cTitle = TextEditingController();
  var cNote = TextEditingController();

  bool _isLoading = false;


//  var dateTime = DateTime.now().toUtc();
  var dateTime = DateFormat('MMMM dd, yyyy').format(DateTime.now().toUtc());
//  March 20, 2019 15:30

  String day = DateTime.now().day.toString();
  String month = DateTime.now().month.toString();
  String year = DateTime.now().year.toString();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          _isLoading = true;
        });
        if (cTitle.text.isNotEmpty || cNote.text.isNotEmpty) {
          return await Services().postNote(title: cTitle.text, note: cNote.text).then((value) {
            Toast.show("Saved successfully", context,duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            return true;
          });
        } else {
          return true;
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xff202125),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text('New Note', style: TextStyle(fontSize: 20),),
//            title: Text('$day $month, $year', style: TextStyle(fontSize: 15),),
//            title: Text("March 20, 2019 15:30",style: TextStyle(fontSize: 15),),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {_isLoading = true;});
                  Services()
                      .postNote(title: cTitle.text, note: cNote.text)
                      .then((value) {
                    setState(() {
                      _isLoading = false;
                      Toast.show("Saved successfully", context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      Navigator.pop(context);
                    });
                  });
                },
              )
            ],
          ),
          body: LoadingOverlay(
            color: Colors.black,
            opacity: .7,
            isLoading: _isLoading,
            progressIndicator: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Saving Note...",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 16, right: 4),
                  child: TextField(
                    controller: cTitle,
                    minLines: 1,
                    maxLines: null,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                    ),
                    decoration: InputDecoration(
                      hintText: "Title",
                      hintStyle: TextStyle(color: Colors.white38, fontSize: 23),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {},
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.only(left: 16, right: 4),
                  child: TextField(
                    controller: cNote,
                    minLines: 1,
                    maxLines: null,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      hintText: "Note",
                      hintStyle: TextStyle(color: Colors.white38, fontSize: 18),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
