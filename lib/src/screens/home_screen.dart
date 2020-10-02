import 'package:flutter/material.dart';
import '../widgets/stories_tab.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  Widget buildBody() {
    if (currentIndex == 0) {
      return TabBarView(
        children: [
          StoriesTab(listType: 'best'),
          StoriesTab(listType: 'top'),
          StoriesTab(listType: 'newest'),
        ],
      );
    } else if (currentIndex == 1) {
      return StoriesTab(listType: 'question');
    } else {
      return StoriesTab(listType: 'job');
    }
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
        bottomBarItem(
          Icon(Icons.home, color: Color.fromRGBO(255, 255, 255, 0.9),),
          Icon(Icons.home, color: Color(0xFF626EE3),)
        ),
        bottomBarItem(
          Icon(Icons.question_answer, color: Color.fromRGBO(255, 255, 255, 0.9),), 
          Icon(Icons.question_answer, color: Color(0xFF626EE3),)
        ),
        bottomBarItem(
          Icon(Icons.work, color: Color.fromRGBO(255, 255, 255, 0.9),), 
          Icon(Icons.work, color: Color(0xFF626EE3),)
        ),
      ],
    );
  }

  BubbleBottomBarItem bottomBarItem(Icon icon, Icon activeIcon) {
    return BubbleBottomBarItem(
      backgroundColor: Color(0xFF626EE3),
      icon: icon,
      activeIcon: activeIcon,
      title: Text("Home", style: TextStyle(fontFamily: 'Ubuntu', fontWeight: FontWeight.w500, fontSize: 14.0)),
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
      backgroundColor: Color(0xFF001528),
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
    );
  }
}