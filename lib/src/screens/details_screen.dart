import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../blocs/comments_provider.dart';
import '../models/item_model.dart';
import '../widgets/comment.dart';
import '../helpers/time_ago.dart';

class DetailsScreen extends StatelessWidget {
  final int itemId;

  DetailsScreen({this.itemId});

  Widget build(context) {
    final bloc = CommentsProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail',
          style: TextStyle(
            fontFamily: 'Ubuntu', 
            fontWeight: FontWeight.w600,
            fontSize: 22.0
          ),
        ),
        elevation: 7.0,
        backgroundColor: Color(0xFF001528),
      ),
      backgroundColor: Color(0xFF001528),
      body: buildBody(bloc),
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: 
        (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF626EE3)),
              ),
            );
          }

          final itemFuture = snapshot.data[itemId];

          return FutureBuilder(
            future: itemFuture,
            builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
              if (!itemSnapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF626EE3)),
                  ),
                );
              }

              return buildList(itemSnapshot.data, snapshot.data);
            },
          );
        },
    );
  }

  Widget buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    final children = <Widget>[];
    children.add(buildTitle(item));
    final commentsList = item.kids.map((kidId) {
      return Comment(itemId: kidId, itemMap: itemMap, depth: 1);
    }).toList();
    children.addAll(commentsList);

    return ListView(
      children: children,
    );
  }

  Widget buildTitle(ItemModel item) {
    // print(item.type);
    // print(item.by);
    // print(item.text);
    // print(item.score);
    // print(item.url);
    return Container(
      margin: EdgeInsets.only(top: 16.0, left: 10.0, right: 10.0, bottom: 10.0),
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Container(
            child: Text(
              item.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22.0,
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.w600,
                color: Color(0xFF6774e4)
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 8.0),
            width: 360,
            child: Text(
              '- Posted by ${item.by} • ${timeAgo(item.time).toLowerCase()} • ${item.score} points',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14.0,
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(255, 255, 255, 0.8)
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 16.0),
            width: 400,
            child: Row(
              children: [
                Icon(Icons.mode_comment, color: Color.fromRGBO(255, 255, 255, 0.8),),
                Text(
                  '  ${item.descendants} Comments', 
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.8), 
                    fontWeight: FontWeight.w700, 
                    fontFamily: 'Poppins',
                    fontSize: 16.0
                  ),
                ),
                Container(
                  width: 60.0,
                  child: Text(
                    '  ', 
                    textAlign: TextAlign.center, 
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.8),
                      fontSize: 30.0
                    ),
                  ),
                ),
                FlatButton.icon(
                  onPressed: () async {
                    var url = item.url;
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  icon: Icon(Icons.link, color: Color.fromRGBO(255, 255, 255, 0.8), size: 30.0),
                  label: Text(
                    'Open Link', 
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.8),
                      fontWeight: FontWeight.w700, 
                      fontFamily: 'Poppins',
                      fontSize: 16.0
                    ),
                  ),
                ),
              ],
            )
          )
        ],        
      ),
      color: Color(0xFF001528),
    );
  }
}