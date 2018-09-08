import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hknews/HKNewsColors.dart';
import 'package:hknews/localization/HKNewsLocalizations.dart';
import 'package:hknews/model/Api.dart';
import 'package:hknews/model/BaseData.dart';
import 'package:hknews/model/News.dart';
import 'package:hknews/widget/TitleAppBar.dart';
import 'package:hknews/widget/VideoItem.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() {
    return _VideoPageState();
  }
}

class _VideoPageState extends State<VideoPage>
    with AutomaticKeepAliveClientMixin<VideoPage> {
  final ScrollController _scrollController = new ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  List<News> _data = [];
  int _curPage = 0;

  @override
  void initState() {
    print("${widget.toString()} initState");
    _scrollController.addListener(handleLoadMore);
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
    BaseData<List<News>, Null> data = await getVideoData(curPage);
    setState(() {
      print("${widget.toString()} setState");
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

  Future<Null> handleLoadMore() async {
    ///判断当前滑动位置是不是到达底部，触发加载更多回调
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      await _getData(_curPage + 1);
    }
    return null;
  }

  @override
  void deactivate() {
    print("${widget.toString()} deactivate");
    super.deactivate();
  }

  @override
  void didChangeDependencies() {
    if (_data.isEmpty) {
      showRefreshLoading();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    print("${widget.toString()} dispose");
    _scrollController.removeListener(handleLoadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("${widget.toString()} build");
    return Scaffold(
      body: _buildRefreshIndicator(),
      appBar: _buildTitle(context),
    );
  }

  ///标题
  _buildTitle(BuildContext context) {
    return TitleAppBar(
      context: context,
      title: Text(
        HKNewsLocalizations.of(context).video,
        style: TextStyle(fontSize: 21.0, color: HKNewsColors.text_white),
      ),
    );
  }

  ///刷新与列表
  _buildRefreshIndicator() {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      child: _buildItem(),
      onRefresh: handleRefresh,
    );
  }

  ///列表item
  ListView _buildItem() {
    return ListView.builder(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return VideoItem(data: _data[index]);
      },
      itemCount: _data.length,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
