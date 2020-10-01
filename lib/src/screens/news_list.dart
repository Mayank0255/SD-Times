import 'package:flutter/material.dart';
import '../widgets/news_tab.dart';

class NewsList extends StatelessWidget {
  Widget build(context) {
    return DefaultTabController(
      length: 3, 
      child: Scaffold(
        appBar: AppBar(
          title: Text('Top News'),
          elevation: 0,
          bottom: TabBar(
            unselectedLabelColor: Color.fromRGBO(98, 110, 227, 1.0),
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: Color.fromRGBO(98, 110, 227, 1.0)
            ),
            tabs: [
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text('Best'),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text('Top'),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text('Newest'),
                ),
              ),
            ],),
          backgroundColor: Color.fromRGBO(21, 49, 75, 1.0),
          shadowColor: Colors.black,
        ),
        body: TabBarView(children: [
          NewsTab(listType: 'best'),
          NewsTab(listType: 'top'),
          NewsTab(listType: 'newest'),
        ],),
        backgroundColor: Color.fromRGBO(0, 21, 40, 1.0),
      ),
    );
  }
}