import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hknews/HKNewsColors.dart';
import 'package:hknews/base/BaseState.dart';
import 'package:hknews/localization/HKNewsLocalizations.dart';

class HomeBar extends StatefulWidget {
  final ValueChanged<int> onTap;

  const HomeBar({Key key, this.onTap}) : super(key: key);

  @override
  _HomeBarState createState() => _HomeBarState();
}

class _HomeBarState extends BaseState<HomeBar> {
  int _index = 0;

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
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _index,
      type: BottomNavigationBarType.fixed,
      onTap: (value) {
        _index = value;
        setState(() {});
        widget.onTap(_index);
      },
      fixedColor: HKNewsColors.blue,
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
    );
  }
}
