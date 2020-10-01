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
            Tab(text: 'Newest',),
            Tab(text: 'Best',),
            Tab(text: 'Top',),
          ],),
          backgroundColor: Color.fromRGBO(21, 49, 75, 1.0),
          shadowColor: Colors.black,
        ),
        body: TabBarView(children: [
          NewsTab(listType: 'newest'),
          NewsTab(listType: 'best'),
          NewsTab(listType: 'top'),
        ],),
        backgroundColor: Color.fromRGBO(0, 21, 40, 1.0),
      ),
    );
  }
}