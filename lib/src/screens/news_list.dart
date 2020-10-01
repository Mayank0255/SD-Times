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
          elevation: 0.1,
          bottom: TabBar(
            unselectedLabelColor: Colors.white,
            indicatorColor: Color.fromRGBO(98, 110, 227, 1.0),
            labelStyle: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
              fontFamily: 'Ubuntu'
            ),
            labelColor: Color.fromRGBO(98, 110, 227, 1.0),
            tabs: [
              Tab(text: 'Best',),
              Tab(text: 'Top',),
              Tab(text: 'Newest',),
            ],
            ),
          backgroundColor: Color(0xFF001528),
          shadowColor: Colors.black,
        ),
        body: TabBarView(children: [
          NewsTab(listType: 'best'),
          NewsTab(listType: 'top'),
          NewsTab(listType: 'newest'),
        ],),
        backgroundColor: Color(0xFF001528),
      ),
    );
  }
}