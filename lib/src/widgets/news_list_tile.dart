import 'package:SD_Times/src/blocs/stories_provider.dart';
import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';
import '../models/item_model.dart';
import '../widgets/loading_container.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile({this.itemId});

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
      elevation: 10.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color(0xFF02203C)),
        child: buildTile(context, item),
      ),
    );
  }

  Widget buildTile(BuildContext context, ItemModel item) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, '/${item.id}');
      },
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
          border: new Border(
            right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 8),),
                Icon(Icons.mode_comment_outlined, color: Colors.white),
                Text('${item.descendants}', style: TextStyle(color: Colors.white))
              ],
            ),
      ),
      title: Text(
        item.title,
        style: TextStyle(color: Colors.white, fontFamily: 'Ubuntu', fontWeight: FontWeight.w600),
      ),
      subtitle: Row(
        children: <Widget>[
          Icon(Icons.linear_scale, color: Color(0xFF626EE3)),
          Text(' ${item.score} points', style: TextStyle(color: Colors.white, fontFamily: 'Ubuntu', fontWeight: FontWeight.w400))
        ],
      ),
      trailing:
        Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0)
    );
  }
}