import 'package:flutter/material.dart';
import 'package:hknews/HKNewsColors.dart';
import 'package:hknews/base/BaseState.dart';
import 'package:hknews/model/News.dart';
import 'package:hknews/page/NewsDetail.dart';
import 'package:hknews/widget/CacheImage.dart';
import 'package:hknews/widget/NewsLikesItem.dart';

class NewsItem extends StatefulWidget {
  final News data;

  const NewsItem({Key key, @required this.data}) : super(key: key);

  @override
  _NewsItemState createState() {
    return _NewsItemState();
  }
}

class _NewsItemState extends BaseState<NewsItem> {
  @override
  Widget build(BuildContext context) {
    News _item = widget.data;
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      child: FlatButton(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        padding: EdgeInsets.only(),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return NewsDetail(url: _item.url);
          }));
        },
        child: Column(
          children: [
            CacheImage.network(
              aspectRatio: 16 / 9,
              path: _item.image,
              placeholder: "images/placeholder.webp",
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Text(
                _item.title,
                style: TextStyle(
                  color: HKNewsColors.text_black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Text(
                _item.description,
                style: TextStyle(
                  color: HKNewsColors.text_grey,
                  fontSize: 11.0,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Text(
                    _item.publishTime.toUpperCase(),
                    style: TextStyle(
                      color: HKNewsColors.text_blue,
                      fontSize: 9.0,
                    ),
                  ),
                  Expanded(
                    child: NewsLikesItem(
                      data: widget.data,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
