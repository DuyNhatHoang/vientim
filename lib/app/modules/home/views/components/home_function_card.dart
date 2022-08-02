import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeFunctionCard extends StatelessWidget {
  final String title;
  final Function onTap;
  final Color bgColor;
  final String image;
  const HomeFunctionCard({Key key, this.title, this.onTap, this.bgColor = Colors.white, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(20)
            ),
            padding: const EdgeInsets.all(13),
            child: Image.asset(
              image,
              height: 40,
              color: Colors.white,
            ),
          ).paddingOnly(bottom: 10),
           Text(
            title,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          )
        ],
      ),
    );
  }
}
