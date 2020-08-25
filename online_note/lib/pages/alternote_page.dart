import 'package:flutter/material.dart';
import 'package:online_note/services.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:intl/intl.dart';

class AlterNotePage extends StatefulWidget {

  final noteId;
  final title;
  final note;
  final timestamp;

  AlterNotePage({Key key, @required this.noteId, @required this.title, @required this.note, @required this.timestamp}) : super(key: key);


  @override
  _AlterNotePageState createState() => _AlterNotePageState();
}

class _AlterNotePageState extends State<AlterNotePage> {

  var cTitle = TextEditingController();
  var cNote = TextEditingController();

  String accountId;
  bool _isLoading = false;

  String noteDate;

  @override
  void initState() {

    var format = DateFormat('MMMM dd, yyyy hh:ss');
    var date = DateTime.fromMillisecondsSinceEpoch(int.parse(widget.timestamp) * 1000);
    noteDate = format.format(date);

    cTitle.text = widget.title!=null ? cTitle.text = widget.title : "";
    cNote.text = widget.note!=null ? cNote.text = widget.note : "";

    SharedPreferences.getInstance().then((value){
      setState(() {
        accountId = value.get('sID');
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {

        if(cTitle.text!=widget.title || cNote.text!=widget.note){
          setState(() {
            _isLoading = true;
          });
          if (cTitle.text.isNotEmpty || cNote.text.isNotEmpty) {
            return await Services().updateNote(
              accountId: accountId??"",
              noteId: widget.noteId,
              title: cTitle.text,
              note: cNote.text,
            ).then((value) {
              Toast.show("Note Updated", context,duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              return true;
            });

          } else {
            return true;
          }
        }else{
          return true;
        }

      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xff202125),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Created in', style: TextStyle(fontSize: 14),),
                Text('$noteDate', style: TextStyle(fontSize: 14),),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                onPressed: () {

                  setState(() {_isLoading = true;});
                  Services().deleteNote(
                    accountId: accountId??"",
                    noteId: widget.noteId
                  ).then((value) {
                    setState(() {
                      Toast.show("Note Deleted", context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      Navigator.pop(context);
                    });
                  });

                },
              ),
              IconButton(
                icon: Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                onPressed: () {

                    setState(() {_isLoading = true;});
                    Services().updateNote(
                      accountId: accountId??"",
                      noteId: widget.noteId,
                      title: cTitle.text,
                      note: cNote.text,
                    ).then((value) {
                      setState(() {
                        Toast.show("Note Updated", context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                        Navigator.pop(context);
                      });
                    });

                },
              ),
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
                  "Please Wait...",
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
