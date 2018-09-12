import 'package:flutter/material.dart';
import 'package:hknews/HKNewsColors.dart';
import 'package:hknews/base/BaseState.dart';
import 'package:hknews/model/News.dart';
import 'package:hknews/page/VideoDetail.dart';
import 'package:hknews/widget/CacheImage.dart';

class VideoItem extends StatefulWidget {
  final News data;
  final bool fromHome;

  const VideoItem({Key key, this.data, this.fromHome: true}) : super(key: key);

  @override
  _VideoItemState createState() {
    return _VideoItemState();
  }
}

class _VideoItemState extends BaseState<VideoItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      child: FlatButton(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        padding: EdgeInsets.zero,
        onPressed: () {
          if (!widget.fromHome) {
            Navigator.pop(context);
          }
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return VideoDetail(data: widget.data);
          }));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CacheImage.network(
              aspectRatio: 16 / 9,
              path: widget.data.image,
              placeholder: "images/placeholder.webp",
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Text(
                widget.data.title,
                maxLines: 100,
                style: TextStyle(
                  color: HKNewsColors.text_black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: Text(
                widget.data.subjectName,
                style: TextStyle(
                  color: HKNewsColors.text_grey,
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
