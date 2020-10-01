import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';
import '../widgets/news_list_tile.dart';
import '../widgets/refresh.dart';


class NewsList extends StatelessWidget {
  Widget build(context) {
    return DefaultTabController(
      length: 3, 
      child: Scaffold(

        appBar: AppBar(
          title: Text('Top News'),
          bottom: TabBar(tabs: [
            Tab(text: "One",),
            Tab(text: "Two",),
            Tab(text: "Three",),
          ],),
          backgroundColor: Color.fromRGBO(21, 49, 75, 1.0),
          shadowColor: Colors.black,
        ),
        body: TabBarView(children: [
          Icon(Icons.movie),
          Icon(Icons.games),
          BuildList(),
        ],),
        backgroundColor: Color.fromRGBO(0, 21, 40, 1.0),
      ),
    );
  }
}

class BuildList extends StatefulWidget {
  createState() {
    return BuildListState();
  }
}

class BuildListState extends State<BuildList> with AutomaticKeepAliveClientMixin {
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