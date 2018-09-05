import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hknews/HKNewsColors.dart';
import 'package:hknews/model/Api.dart';
import 'package:hknews/model/BaseData.dart';
import 'package:hknews/model/News.dart';
import 'package:hknews/page/NewsDetail.dart';
import 'package:hknews/widget/CacheImage.dart';
import 'package:hknews/widget/NewsItem.dart';

class HotNewPage extends StatefulWidget {
  @override
  _HotNewPageState createState() {
    print("${toString()} createState");
    return _HotNewPageState();
  }
}

class _HotNewPageState extends State<HotNewPage>
    with AutomaticKeepAliveClientMixin<HotNewPage> {
  final List<News> _data = [];
  final List<News> _hotData = [];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    print("${widget.toString()} initState");
    super.initState();
  }

  showRefreshLoading() {
    new Future.delayed(const Duration(seconds: 0), () {
      _refreshIndicatorKey.currentState.show().then((e) {});
      return true;
    });
  }

  _getData() async {
    BaseData<List<News>, List<News>> data = await getHotNewsData();
    print("${widget.toString()} setState");
    setState(() {
      _data.clear();
      _hotData.clear();
      _data.addAll(data.a);
      _hotData.addAll(data.b);
    });
    return null;
  }

  Future<Null> handleRefresh() async {
    await _getData();
    return null;
  }

  @override
  void deactivate() {
    print("${widget.toString()} deactivate");
    super.deactivate();
  }

  @override
  void dispose() {
    print("${widget.toString()} dispose");
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    print("${widget.toString()} didChangeDependencies");
    if (_data.isEmpty) {
      showRefreshLoading();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print("${widget.toString()} build");
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      child: _buildItem(),
      onRefresh: handleRefresh,
    );
  }

  ListView _buildItem() {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (_hotData.isNotEmpty && index == 0) {
          return _buildHeader();
        } else {
          News _item = _data[_hotData.isEmpty ? index : index - 1];
          return NewsItem(data: _item);
        }
      },
      itemCount: _hotData.isEmpty ? _data.length : _data.length + 1,
    );
  }

  DefaultTabController _buildHeader() {
    return DefaultTabController(
      length: _hotData.length,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          children: <Widget>[
            TabBarView(
              children: _hotData.map((News value) {
                return Stack(
                  children: <Widget>[
                    CacheImage.network(
                      aspectRatio: 16 / 9,
                      path: value.image,
                      placeholder: "images/placeholder.webp",
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 16.0,
                          top: 24.0,
                          right: 16.0,
                          bottom: 24.0,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              HKNewsColors.transparent,
                              HKNewsColors.transparent_half
                            ],
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Text(
                                value.title,
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color: HKNewsColors.text_white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    FlatButton(
                      padding: EdgeInsets.only(),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return NewsDetail(url: value.url);
                        }));
                      },
                      child: Container(),
                    ),
                  ],
                );
              }).toList(),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: EdgeInsets.only(
                  right: 16.0,
                  bottom: 6.0,
                ),
                child: TabPageSelector(
                  selectedColor: HKNewsColors.text_white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
