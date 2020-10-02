import 'dart:math';
import 'package:SD_Times/src/blocs/stories_provider.dart';
import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';
import '../models/item_model.dart';
import 'loading_container.dart';
import 'package:url_launcher/url_launcher.dart';

class StoriesListTile extends StatelessWidget {
  final int itemId;

  StoriesListTile({this.itemId});

  Widget build(context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (context, itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return LoadingContainer();
            }

            return buildCard(context, itemSnapshot.data);
          },
        );
      }
    );
  }

  Widget buildCard(BuildContext context, ItemModel item) {
    return Card(
      elevation: 12.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),  
      child: Container(
        padding: new EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.5),
        decoration: BoxDecoration(color: Color(0xFF022240)),
        child: buildTile(context, item),
      ),
    );
  }

  Widget buildTile(BuildContext context, ItemModel item) {
    final children = <Widget>[];
    
    children.add(Padding(padding: EdgeInsets.only(top: 8),));
    if (item.descendants == null) {
      children.addAll([
        Padding(padding: EdgeInsets.only(top: 8),),
        Transform.rotate(
          angle: pi / 2,
          child: Icon(Icons.link, color: Colors.white)
      )]);
    } else {
      children.addAll([
        Icon(Icons.mode_comment_outlined, color: Colors.white),
        Text('${item.descendants}', style: TextStyle(color: Colors.white))
      ]);
    }

    return ListTile(
      onTap: () async {
        if (item.descendants != null) {
          Navigator.pushNamed(context, '/${item.id}');
        } else {
          var url = item.url;
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        }
      },
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
          border: new Border(
            right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Column(
              children: children,
            ),
      ),
      title: Text(
        item.title,
        style: TextStyle(color: Colors.white, fontFamily: 'Ubuntu', fontWeight: FontWeight.w600),
      ),
      subtitle: Row(
        children: <Widget>[
          Icon(Icons.linear_scale, color: Color(0xFF626EE3)),
          Text((item.descendants == null) ? ' ${item.by}' : ' ${item.score} points', style: TextStyle(color: Colors.white, fontFamily: 'Ubuntu', fontWeight: FontWeight.w400))
        ],
      ),
      trailing:
        Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0)
    );
  }
}