import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:simple_ecomerce/const/custom_color.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;

  CustomSearchBar({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.only(left: 20,right: 20, bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Container(
              child: TextField(
                controller: controller,
                style: TextStyle(color: Colors.black, fontSize: 16),
                decoration: InputDecoration(
                  icon: Icon(
                    Feather.search,
                    color: CustomColor.red,
                    size: 22,
                  ),
                  hintText: "Search pants or shirt",
                  hintStyle: TextStyle(color: Colors.black26),
                  border: InputBorder.none,
                ),
                onChanged: (value) {},
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                decoration: BoxDecoration(
                  color: CustomColor.red,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Feather.x,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              onTap: () {
                controller.clear();
              },
            ),
          ],
        ));
  }
}
