import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  Widget build(context) {
    return Column(
      children: [
        ListTile(
          title: buildContainer(20.0, 25.0, 5.0, 5.0),
          subtitle: buildContainer(20.0, 55.0, 5.0, 5.0),
          trailing: buildContainer(50.0, 0, 0, 0),
          contentPadding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
        ),
        Divider(
          height: 10.0,
          color: Color.fromRGBO(98, 110, 227, 1.0),
          thickness: 1.5,
          indent: 16.0,
          endIndent: 16.0,
        )
      ],
    );
  }

  Widget buildContainer(double height, double right, double top, double bottom) {
    return Container(
      color: Color.fromRGBO(22, 52, 80, 1.0),
      height: height,
      width: 50.0,
      margin: EdgeInsets.only(top: top, bottom: bottom, right: right),
    );
  }
}