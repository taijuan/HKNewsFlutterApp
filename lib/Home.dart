import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hknews/HKNewsColors.dart';
import 'package:hknews/base/BaseState.dart';
import 'package:hknews/localization/HKNewsLocalizations.dart';
import 'package:hknews/page/EPaperPage.dart';
import 'package:hknews/page/MePage.dart';
import 'package:hknews/page/NewsPage.dart';
import 'package:hknews/page/VideoPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    print("${toString()} createState");
    return _HomePageState();
  }
}

class _HomePageState extends BaseState<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  void initState() {
    print("${widget.toString()} initState");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("${widget.toString()} build");
    return CupertinoTabScaffold(
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return NewsPage(map: NEWS);
          case 1:
            return NewsPage(map: FOCUS);
          case 2:
            return EPaperPage();
          case 3:
            return VideoPage();
          case 4:
            return MePage();
        }
      },
      tabBar: CupertinoTabBar(
        activeColor: HKNewsColors.blue,
        inactiveColor: HKNewsColors.grey,
        items: [
          _buildTab(
            "images/news.webp",
            "images/news_selected.webp",
            HKNewsLocalizations.of(context).news,
          ),
          _buildTab(
            "images/focus.webp",
            "images/focus_selected.webp",
            HKNewsLocalizations.of(context).focus,
          ),
          _buildTab(
            "images/epaper.webp",
            "images/epaper_selected.webp",
            HKNewsLocalizations.of(context).ePaper,
          ),
          _buildTab(
            "images/video.webp",
            "images/video_selected.webp",
            HKNewsLocalizations.of(context).video,
          ),
          _buildTab(
            "images/me.webp",
            "images/me_selected.webp",
            HKNewsLocalizations.of(context).me,
          )
        ],
      ),
    );
  }

  _buildTab(String icon, String activeIcon, String text) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        icon,
        width: 24.0,
        height: 24.0,
      ),
      activeIcon: Image.asset(
        activeIcon,
        width: 24.0,
        height: 24.0,
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 12.0,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
