import 'package:flutter/material.dart';
import 'package:hknews/base/BaseState.dart';
import 'package:hknews/page/EPaperPage.dart';
import 'package:hknews/page/MePage.dart';
import 'package:hknews/page/NewsPage.dart';
import 'package:hknews/page/VideoPage.dart';
import 'package:hknews/widget/HomeBar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    print("${toString()} createState");
    return _HomePageState();
  }
}

class _HomePageState extends BaseState<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    print("${widget.toString()} initState");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("${widget.toString()} build");
    return Scaffold(
      body: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 5,
        controller: _pageController,
        itemBuilder: (context, index) {
          if (index == 0) {
            return NewsPage(map: NEWS);
          } else if (index == 1) {
            return NewsPage(map: FOCUS);
          } else if (index == 2) {
            return EPaperPage();
          } else if (index == 3) {
            return VideoPage();
          } else {
            return MePage();
          }
        },
      ),
      bottomNavigationBar: HomeBar(
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
