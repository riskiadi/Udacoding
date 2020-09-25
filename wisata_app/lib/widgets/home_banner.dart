import 'package:flutter/material.dart';
import 'package:wisata_app/ui/profile.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({
    Key key,
    @required this.size,
    @required this.nama,
    @required this.email,
    @required this.photoURI,
  }) : super(key: key);

  final Size size;
  final String nama;
  final String email;
  final String photoURI;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Image.asset(
            'assets/image/banner.jpg',
            height: 300,
            width: size.width,
            fit: BoxFit.cover,
          ),
        ),

        Positioned(
          bottom: 0,
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withOpacity(0.6),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
              ),
            ),
          ),
        ),

        Positioned(
          top: 20,
          left: 15,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, ${nama.split(" ")[0]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                        maxLines: 2,
                      ),
                      Text(
                        "Welcome to Travel App",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  )
              ),
              InkWell(
                child: Container(
                  padding: const EdgeInsets.all(1.5),
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.8), borderRadius: BorderRadius.circular(60)),
                  child: ClipOval(
                    child: Hero(
                      tag: 'profile_image',
                      child: Image.network(
                        photoURI??'https://www.freeiconspng.com/uploads/loading-icon-1.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(name: nama, email: email, photo: photoURI,),));
                },
              ),
            ],
          ),
        ),

        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              height: 70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "We have best travel destination",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Check list below",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
          ),
        ),

      ],
    );
  }
}