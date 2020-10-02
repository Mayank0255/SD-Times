import 'package:flutter/material.dart';
import '../widgets/news_tab.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

class NewsList extends StatefulWidget {
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  int currentIndex;

  @override
  void initState() {
    super.initState();

    currentIndex = 0;
  }

  changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Widget build(context) {
    return DefaultTabController(
      length: 3, 
      child: Scaffold(
        appBar: topAppBar(),
        backgroundColor: Color(0xFF001528),
        bottomNavigationBar: BubbleBottomBar(
          opacity: 0.2,
          backgroundColor: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
          currentIndex: currentIndex,
          hasInk: true,
          inkColor: Colors.black12,
          hasNotch: true,
          onTap: changePage,
          items: <BubbleBottomBarItem>[
            BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(Icons.dashboard, color: Colors.black,),
              activeIcon: Icon(Icons.dashboard, color: Colors.red,),
              title: Text("Home"),
            ),
            BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(Icons.dashboard, color: Colors.black,),
              activeIcon: Icon(Icons.dashboard, color: Colors.red,),
              title: Text("Home"),
            ),
            BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(Icons.dashboard, color: Colors.black,),
              activeIcon: Icon(Icons.dashboard, color: Colors.red,),
              title: Text("Home"),
            ),
          ],
        ),
        body: (currentIndex == 0)
            ? TabBarView(children: [
                NewsTab(listType: 'best'),
                NewsTab(listType: 'top'),
                NewsTab(listType: 'newest'),
              ],)
            : (currentIndex == 1)
            ? Icon(
                Icons.folder_open,
                size: 150.0,
                color: Colors.indigo,
              )
            : Icon(
                Icons.access_time,
                size: 150.0,
                color: Colors.deepPurple,
              ),
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