import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  Widget build(context) {
    return Column(
      children: [
        ListTile(
          title: buildContainer(20.0, 25.0, 5.0, 5.0),
          subtitle: buildContainer(20.0, 55.0, 5.0, 5.0),
          trailing: buildContainer(50.0, 0, 0, 0),
        ),
        Divider(
          height: 8.0,
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