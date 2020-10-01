import 'package:flutter/material.dart';
import 'news_list_tile.dart';
import 'refresh.dart';
import '../blocs/stories_provider.dart';

class NewsTab extends StatefulWidget {
  createState() {
    return NewsTabState();
  }
}

class NewsTabState extends State<NewsTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Widget build(context) {
    super.build(context);
    final bloc = StoriesProvider.of(context);

    bloc.fetchTopIds();

    return StreamBuilder(
      stream: bloc.topIds,
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