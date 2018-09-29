import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hknews/HKNewsColors.dart';
import 'package:hknews/base/BaseState.dart';
import 'package:hknews/model/Api.dart';
import 'package:hknews/model/News.dart';

class NewsLikesItem extends StatefulWidget {
  final News data;

  const NewsLikesItem({Key key, this.data}) : super(key: key);

  @override
  _NewsLikesItemState createState() {
    return _NewsLikesItemState();
  }
}

class _NewsLikesItemState extends BaseState<NewsLikesItem> {
  String likes;

  refresh() async {
    int i = await getLikes(widget.data.dataId);
    if (i == 0) {
      likes = "";
    } else if (i == 1) {
      likes = "1 like";
    } else {
      likes = "$i likes";
    }
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    if (likes == null) {
      refresh();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8.0),
      alignment: Alignment.centerLeft,
      child: Text(
        likes ?? "",
        textAlign: TextAlign.start,
        style: TextStyle(color: HKNewsColors.text_grey, fontSize: 11.0),
      ),
    );
  }
}
