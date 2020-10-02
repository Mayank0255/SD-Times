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
        bottomNavigationBar: bottomAppBar(),
        body: buildBody(),
      ),
    );
  }

  Widget buildNewsPage() {
    return TabBarView(
      children: [
        NewsTab(listType: 'best'),
        NewsTab(listType: 'top'),
        NewsTab(listType: 'newest'),
      ],
    );
  }

  Widget buildBody() {
    return (currentIndex == 0)
      ? buildNewsPage()
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
        );
  }

  Widget bottomAppBar() {
    return BubbleBottomBar(
      opacity: 0.2,
      backgroundColor: Color(0xFF001528),
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      currentIndex: currentIndex,
      hasInk: true,
      inkColor: Colors.white,
      hasNotch: true,
      onTap: changePage,
      items: <BubbleBottomBarItem>[
        BubbleBottomBarItem(
          backgroundColor: Color(0xFF626EE3),
          icon: Icon(Icons.home, color: Color.fromRGBO(255, 255, 255, 0.9),),
          activeIcon: Icon(Icons.home, color: Color(0xFF626EE3),),
          title: Text("Home", style: TextStyle(fontFamily: 'Ubuntu', fontWeight: FontWeight.w500, fontSize: 14.0)),
        ),
        BubbleBottomBarItem(
          backgroundColor: Color(0xFF626EE3),
          icon: Icon(Icons.question_answer_rounded, color: Color.fromRGBO(255, 255, 255, 0.9),),
          activeIcon: Icon(Icons.question_answer_rounded, color: Color(0xFF626EE3),),
          title: Text("Questions", style: TextStyle(fontFamily: 'Ubuntu', fontWeight: FontWeight.w500, fontSize: 14.0)),
        ),
        BubbleBottomBarItem(
          backgroundColor: Color(0xFF626EE3),
          icon: Icon(Icons.work, color: Color.fromRGBO(255, 255, 255, 0.9),),
          activeIcon: Icon(Icons.work, color: Color(0xFF626EE3),),
          title: Text("Jobs", style: TextStyle(fontFamily: 'Ubuntu', fontWeight: FontWeight.w500, fontSize: 14.0)),
        ),
      ],
    );
  }

  Widget topAppBar() {
    return AppBar(
      title: Text(
        (currentIndex == 0)
        ? 'News Feed'
        : (currentIndex == 1)
        ? 'Questions'
        : 'Jobs',
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
      bottom: (currentIndex == 0) ? TabBar(
        unselectedLabelColor: Colors.white,
        indicatorColor: Color(0xFF6774e4),
        indicatorSize: TabBarIndicatorSize.tab,
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
      ) : null,
      backgroundColor: Color(0xFF001528),
    );
  }
}