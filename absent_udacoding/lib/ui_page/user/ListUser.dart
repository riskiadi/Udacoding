import 'package:absent_udacoding/constant/ConstantFile.dart';
import 'package:absent_udacoding/model/ModelAbsent.dart';
import 'package:flutter/material.dart';
import '../profile/ProfileList.dart';

class ListUser extends StatelessWidget {
  String myId, myEmail, myName, myPhoto;
  final list;
  ListUser({this.list});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            Absent data = list[index];
            return Padding(
              padding: const EdgeInsets.all(5),
              child: GestureDetector(
                child: Card(
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                  ConstantFile().imageUrl + data.photoUser,
                                ),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    title: Text(data?.fullnameUser ?? ""),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileList(
                                  idUser: data.idUser,
                                  nama: data.fullnameUser,
                                  role: data.nameRole,
                                  email: data.emailUser,
                                  phone: data.phoneUser,
                                  photo: data.photoUser)));
                    },
                  ),
                ),
              ),
            );
          }),
    );
  }
}
