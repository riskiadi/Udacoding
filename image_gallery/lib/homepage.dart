import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_gallery/detail.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String tittle = "Hi, Strangers";
  String subTittle = "Welcome to Gallery";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 30, bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tittle,
                    style: GoogleFonts.lobster(
                      fontWeight: FontWeight.w600,
                      fontSize: 40,
                      color: Color(0xff1A1B4F),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    subTittle,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Color(0xff1A1B4F),
                    ),
                  ),
                ],
              )),
          StaggeredGridView.countBuilder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            itemCount: 14,
            staggeredTileBuilder: (index) => StaggeredTile.fit(1),
            itemBuilder: (counter, index) {
              return Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    child: Image.asset('assets/${index}.jpg'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              imageURI: "assets/${index}.jpg",
                            ),
                          ));
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
