import 'package:flutter/material.dart';
import 'package:hknews/HKNewsColors.dart';
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

class _NewsPageState extends State<NewsPage>
    with AutomaticKeepAliveClientMixin<NewsPage> {
  @override
  void initState() {
    print("${widget.toString()} initState");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.map.length,
      child: Scaffold(
        appBar: TitleAppBar(
          context: context,
          title: Image.asset(
            "images/top_logo.webp",
          ),
        ),
        body: Scaffold(
          appBar: TabBar(
            indicatorPadding: EdgeInsets.symmetric(horizontal: 12.0),
            tabs: widget.map.keys.map((value) {
              return Container(
                height: 36.0,
                child: Center(
                  child: Text(
                    value,
                    textDirection: TextDirection.ltr,
                  ),
                ),
              );
            }).toList(),
            isScrollable: true,
            labelColor: HKNewsColors.blue,
            unselectedLabelColor: HKNewsColors.grey,
          ),
          body: TabBarView(
            children: widget.map.values.map((value) {
              if (value == "home") {
                return HotNewPage();
              }
              return NewPage(
                name: value,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
