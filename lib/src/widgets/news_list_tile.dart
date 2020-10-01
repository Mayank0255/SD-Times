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

            return buildTile(context, itemSnapshot.data);
          },
        );
      }
    );
  }

  Widget buildTile(BuildContext context, ItemModel item) {
    return Column(
      children: [
        ListTile(
          // isThreeLine: true,
          onTap: () {
            Navigator.pushNamed(context, '/${item.id}');
          },
          title: Text(item.title, style: TextStyle(color: Color.fromRGBO(98, 110, 227, 1.0), fontFamily: 'Ubuntu', fontWeight: FontWeight.w500)),
          subtitle: Text('${item.score} points', style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.8), fontFamily: 'Ubuntu', fontWeight: FontWeight.w400)),
          trailing: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 10),),
              Icon(Icons.mode_comment, color: Color.fromRGBO(98, 110, 227, 1.0)),
              Text('${item.descendants}', style: TextStyle(color: Color(0xFFF92672)),)
            ]
          ),
          contentPadding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 32.0, right: 16.0),
        ),
        Divider(
          height: 10.0,
          color: Color.fromRGBO(187, 204, 221, 0.8),
          thickness: 1,
          indent: 17.0,
          endIndent: 17.0,
        )
      ],
    );
  }
}