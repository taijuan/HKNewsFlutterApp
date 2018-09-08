import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hknews/model/Api.dart';
import 'package:hknews/model/BaseData.dart';
import 'package:hknews/model/News.dart';
import 'package:hknews/widget/NewsItem.dart';

class NewPage extends StatefulWidget {
  final String name;

  const NewPage({Key key, @required this.name}) : super(key: key);

  @override
  _NewPageState createState() {
    print("$name createState");
    return _NewPageState();
  }
}

class _NewPageState extends State<NewPage>
    with AutomaticKeepAliveClientMixin<NewPage> {
  final ScrollController _scrollController = new ScrollController();
  final List<News> _data = [];
  int _curPage = 0;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    print("${widget.name} initState");
    _scrollController.addListener(() {
      ///判断当前滑动位置是不是到达底部，触发加载更多回调
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getData(_curPage + 1);
      }
    });
    super.initState();
  }

  showRefreshLoading() {
    new Future.delayed(const Duration(seconds: 0), () {
      _refreshIndicatorKey.currentState.show().then((e) {});
      return true;
    });
  }

  _getData(int curPage) async {
    _curPage = curPage;
    BaseData<List<News>, Null> data = await getNewsData(widget.name, curPage);
    print("${widget.name} setState");
    setState(() {
      if (curPage == 1) {
        _data.clear();
      }
      _data.addAll(data.a);
    });
    return null;
  }

  Future<Null> handleRefresh() async {
    await _getData(1);
    return null;
  }

  @override
  void deactivate() {
    print("${widget.name} deactivate");
    super.deactivate();
  }

  @override
  void dispose() {
    print("${widget.name} dispose");
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
    print("${widget.name} build");
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      child: _buildItem(),
      onRefresh: handleRefresh,
    );
  }

  ListView _buildItem() {
    return ListView.builder(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        News _item = _data[index];
        return NewsItem(data:_item);
      },
      itemCount: _data.length,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
