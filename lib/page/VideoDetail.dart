import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hknews/HKNewsColors.dart';
import 'package:hknews/model/Api.dart';
import 'package:hknews/model/BaseData.dart';
import 'package:hknews/model/News.dart';
import 'package:hknews/widget/HeaderVideoTitleBar.dart';
import 'package:hknews/widget/VideoItem.dart';

class VideoDetail extends StatefulWidget {
  final News data;

  const VideoDetail({Key key, @required this.data}) : super(key: key);

  @override
  _VideoDetailState createState() {
    return _VideoDetailState();
  }
}

class _VideoDetailState extends State<VideoDetail> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  final List<News> _data = [];

  Future<Null> _getData() async {
    BaseData data = await getLastVideo(widget.data.subjectCode);
    setState(() {
      _data.clear();
      _data.addAll(data.a);
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderVideoTitleBar(
        context: context,
        data: widget.data,
      ),
      body: _buildListView(),
    );
  }

  showRefreshLoading() {
    new Future.delayed(const Duration(seconds: 0), () {
      _refreshIndicatorKey.currentState.show().then((e) {});
      return true;
    });
  }

  @override
  void didChangeDependencies() {
    if (_data.isEmpty) {
      showRefreshLoading();
    }
    super.didChangeDependencies();
  }

  RefreshIndicator _buildListView() {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      child: ListView.builder(
        itemBuilder: (context, index) {
          if (index == 0) {
            return _introCard();
          }
          return VideoItem(
            data: _data[index - 1],
            fromHome: false,
          );
        },
        itemCount: _data.isEmpty ? 0 : _data.length + 1,
      ),
      onRefresh: _getData,
    );
  }

  Widget _introCard() {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(4.0),
        ),
      ),
      margin: EdgeInsets.only(
        left: 16.0,
        top: 16.0,
        right: 16.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              widget.data.title,
              style: TextStyle(
                color: HKNewsColors.text_black,
                fontSize: 17.0,
                height: 1.33,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: Text(
              widget.data.description,
              style: TextStyle(
                height: 1.2,
                color: HKNewsColors.text_grey,
                fontSize: 13.0,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.only(right: 6.0),
                    width: 3.0,
                    height: 13.0,
                    color: HKNewsColors.text_blue),
                Text(
                  widget.data.subjectName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    wordSpacing: 2.0,
                    color: HKNewsColors.text_blue,
                    fontSize: 14.0,
                  ),
                ),
                Container(
                  width: 8.0,
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    widget.data.publishTime,
                    style: TextStyle(
                      color: HKNewsColors.text_grey,
                      fontSize: 12.0,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
