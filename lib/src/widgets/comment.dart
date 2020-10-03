import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item_model.dart';
import 'loading_container.dart';
import '../helpers/parse_html.dart';
import '../helpers/time_ago.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment({this.itemId, this.itemMap, this.depth});
  
  Widget build(context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        final item = snapshot.data;

        final children = <Widget>[
          Card(
            color: Color(0xFF163450),
            margin: EdgeInsets.all(0),
            elevation: 10.0,
            child: Container(
              decoration: BoxDecoration(
                border: Border(left: BorderSide(width: 1.3, color: Color.fromRGBO(255, 255, 255, 0.5)))
              ),
              margin: EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
                right: 16.0,
                left: depth * 16.0,
              ),
              child: buildTile(context, item),
            ),
          ),
          Divider(),
        ];

        item.kids.forEach((kidId) {
          children.add(
            Comment(itemId: kidId, itemMap: itemMap, depth: depth + 1),
          );
        });

        return Column(
          children: children,
        );
      },
    );
  }

  Widget buildTile(BuildContext context, ItemModel item) {
    return ListTile(
      title: Row(
      children: [
        Text(
          item.by == '' ? '[Deleted by moderator]' : '${item.by}',
          style: TextStyle(
            color: Color(0xFF6774e4),
            fontSize: 18.0
          ),
        ),
        Text(
          ' • ${timeAgo(item.time).toLowerCase()}',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 15.0
          ),
        )
      ],
      ),
      subtitle: Text(
        parseHtmlString(item.text),
        style: TextStyle(
          color: Color.fromRGBO(255, 255, 255, 0.9)
        ),
      ),
      tileColor: Color(0xFF163450),
    );
  }
}