import 'package:flutter/material.dart';
import 'package:hknews/HKNewsColors.dart';
import 'package:hknews/base/BaseState.dart';
import 'package:hknews/page/HotNewPage.dart';
import 'package:hknews/page/NewPage.dart';
import 'package:hknews/widget/TitleAppBar.dart';

const Map<String, String> NEWS = {
  "HOME": "home",
  "HONG KONG": "hong_kong",
  "NATION": "nation",
  "ASIA": "asia",
  "WORLD": "world",
  "BUSINESS": "business",
  "DATA": "data",
  "SPORTS": "sports"
};

const Map<String, String> FOCUS = {
  "LIFE & ART": "life_art",
  "LEADERS": "leaders",
  "OFFBEAT HK": "offbeat_hk",
  "IN-DEPTH CHINA": "in_depth_china",
  "EYE ON ASIA": "eye_on_asia",
  "QUIRKY": "quirky",
  "PHOTO": "photo"
};

class NewsPage extends StatefulWidget {
  final Map<String, String> map;

  const NewsPage({Key key, @required this.map}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends BaseState<NewsPage>
    with
        AutomaticKeepAliveClientMixin<NewsPage>,
        SingleTickerProviderStateMixin<NewsPage> {
  TabController _tabController;
  final PageController _pageController = PageController();
  List<Widget> _tabs = [];

  @override
  void initState() {
    print("${widget.toString()} initState");
    _tabController = TabController(length: widget.map.length, vsync: this);
    for (int i = 0; i < widget.map.length; i++) {
      _tabs.add(
        Container(
          height: 36.0,
          child: InkWell(
            enableFeedback: false,
            onTap: () {
              _pageController.jumpToPage(i);
            },
            child: Center(
              child: Text(
                widget.map.keys.toList()[i],
                textDirection: TextDirection.ltr,
              ),
            ),
          ),
        ),
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleAppBar(
        context: context,
        title: Image.asset(
          "images/top_logo.webp",
        ),
      ),
      body: Scaffold(
        appBar: TabBar(
          controller: _tabController,
          indicatorPadding: EdgeInsets.symmetric(horizontal: 12.0),
          tabs: _tabs,
          isScrollable: true,
          labelColor: HKNewsColors.blue,
          unselectedLabelColor: HKNewsColors.grey,
        ),
        body: PageView.builder(
          controller: _pageController,
          onPageChanged: (index) {
            _tabController.animateTo(index);
          },
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            String value = widget.map.values.toList()[index];
            if (value == "home") {
              return HotNewPage();
            } else {
              return NewPage(
                name: value,
              );
            }
          },
          itemCount: widget.map.length,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
