import 'package:flutter/material.dart';
import '../widgets/news_tab.dart';

class NewsList extends StatelessWidget {
  Widget build(context) {
    return DefaultTabController(
      length: 3, 
      child: Scaffold(
        appBar: topAppBar(),
        body: TabBarView(children: [
          NewsTab(listType: 'best'),
          NewsTab(listType: 'top'),
          NewsTab(listType: 'newest'),
        ],),
        backgroundColor: Color(0xFF001528),
      ),
    );
  }

  Widget topAppBar() {
    return AppBar(
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
          top: 15.0,
          bottom: 9.0
        ),
        child: Image.asset('assets/SD-Splash-Icon.png'),
      ),
      elevation: 7.0,
      bottom: TabBar(
        unselectedLabelColor: Colors.white,
        indicatorColor: Color(0xFF6774e4),
        labelStyle: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w400,
          fontFamily: 'Ubuntu'
        ),
        labelColor: Color(0xFF6774e4),
        tabs: [
          Tab(text: 'Best',),
          Tab(text: 'Top',),
          Tab(text: 'Newest',),
        ],
      ),
      backgroundColor: Color(0xFF001528),
    );
  }
}