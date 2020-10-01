import 'package:flutter/material.dart';
import 'news_list_tile.dart';
import 'refresh.dart';
import '../blocs/stories_provider.dart';

class NewsTab extends StatefulWidget {
  final String listType;

  NewsTab({this.listType});

  @override
  _NewsTabState createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Widget build(context) {
    super.build(context);
    final bloc = StoriesProvider.of(context);
    Stream<List<int>> streamType;

    switch(widget.listType) {
      case 'newest': {
        bloc.fetchNewestIds();
        streamType = bloc.newestIds;
      }
      break;
      case 'best': {
        bloc.fetchBestIds();
        streamType = bloc.bestIds;
      }
      break;
      case 'top': {
        bloc.fetchTopIds();
        streamType = bloc.topIds;
      }
      break;
    }

    return StreamBuilder(
      stream: streamType,
      builder: (context, AsyncSnapshot<List<int>>snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Refresh(
          child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, int index) {
              bloc.fetchItem(snapshot.data[index]);

              return NewsListTile(
                itemId: snapshot.data[index]
              );
            },
          ),
        );
      },
    );
  }
}