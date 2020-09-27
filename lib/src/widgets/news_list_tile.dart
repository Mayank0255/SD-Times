import 'package:SD_Times/src/blocs/stories_provider.dart';
import 'package:flutter/material.dart';
import '../blocs/stories_bloc.dart';
import '../models/item_model.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile({this.itemId});

  Widget build(context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('Stream still loading...');
        }

        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (context, itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return ListTile(
                title: Text('$itemId is still loading'),
              );
            }

            return buildTile(itemSnapshot.data);
          },
        );
      }
    );
  }

  Widget buildTile(ItemModel item) {
    return Column(
      children: [
        ListTile(
          title: Text(item.title),
          subtitle: Text('${item.score} points'),
          trailing: Column(
            children: [
              Icon(Icons.comment),
              Text('${item.descendants}')
            ]
          ),
        ),
        Divider(
          height: 8.0,
        )
      ],
    );
  }
}