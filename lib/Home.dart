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
  int _index = 0;

  @override
  void initState() {
    print("${widget.toString()} initState");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("${widget.toString()} build");
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          NewsPage(map: NEWS),
          NewsPage(map: FOCUS),
          EPaperPage(),
          VideoPage(),
          MePage(),
        ],
      ),
      bottomNavigationBar: HomeBar(
        curIndex: _index,
        onTap: (index) {
          _index = index;
          setState(() {});
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
