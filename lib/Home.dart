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
  int _index = 0;

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
        items: [
          _buildTab(
            _index == 0 ? "images/news_selected.webp" : "images/news.webp",
            HKNewsLocalizations.of(context).news,
            _index == 0,
          ),
          _buildTab(
            _index == 1 ? "images/focus_selected.webp" : "images/focus.webp",
            HKNewsLocalizations.of(context).focus,
            _index == 1,
          ),
          _buildTab(
            _index == 2 ? "images/epaper_selected.webp" : "images/epaper.webp",
            HKNewsLocalizations.of(context).ePaper,
            _index == 2,
          ),
          _buildTab(
            _index == 3 ? "images/video_selected.webp" : "images/video.webp",
            HKNewsLocalizations.of(context).video,
            _index == 3,
          ),
          _buildTab(
            _index == 4 ? "images/me_selected.webp" : "images/me.webp",
            HKNewsLocalizations.of(context).me,
            _index == 4,
          )
        ],
        currentIndex: _index,
        onTap: (index) {
          _index = index;
          setState(() {});
        },
      ),
    );
  }

  _buildTab(String icon, String text, bool select) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        icon,
        width: 24.0,
        height: 24.0,
      ),
      title: Text(
        text,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12.0,
          color: select ? HKNewsColors.blue : HKNewsColors.grey,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
