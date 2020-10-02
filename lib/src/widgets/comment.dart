import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item_model.dart';
import 'loading_container.dart';
import '../helpers/parse_html.dart';

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
          ListTile(
            title: Text(parseHtmlString(item.text), style: TextStyle(color: Colors.white70),),
            subtitle: item.by == '' ? Text('[Deleted by moderator]') : Text(item.by),
            contentPadding: EdgeInsets.only(
              right: 16.0,
              left: depth * 16.0,
            ),
          ),
          Divider()
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
}