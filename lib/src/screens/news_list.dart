import 'package:flutter/material.dart';
import '../widgets/news_tab.dart';

class NewsList extends StatelessWidget {
  Widget build(context) {
    return DefaultTabController(
      length: 3, 
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'News Feed',
            style: TextStyle(
              fontFamily: 'Ubuntu', 
              fontWeight: FontWeight.w600,
              fontSize: 22.0
            ),
          ),
          leading: Padding(
            padding: EdgeInsets.only(
              top: 12.0,
              bottom: 12.0
            ),
            child: Image.asset('assets/SD-Splash-Icon.png'),
          ),
          elevation: 0,
          bottom: TabBar(
            unselectedLabelColor: Color.fromRGBO(98, 110, 227, 1.0),
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              color: Color.fromRGBO(98, 110, 227, 1.0)
            ),
            labelStyle: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
              fontFamily: 'Ubuntu'
            ),
            tabs: [
              Tab(text: 'Best',),
              Tab(text: 'Top',),
              Tab(text: 'Newest',),
            ],
            ),
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