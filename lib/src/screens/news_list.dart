import 'package:flutter/material.dart';
import '../widgets/news_tab.dart';

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
          NewsTab(),
        ],),
        backgroundColor: Color.fromRGBO(0, 21, 40, 1.0),
      ),
    );
  }
}