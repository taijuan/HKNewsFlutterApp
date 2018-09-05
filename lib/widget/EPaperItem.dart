import 'package:flutter/material.dart';
import 'package:hknews/HKNewsColors.dart';
import 'package:hknews/model/Api.dart';
import 'package:hknews/model/EPaper.dart';
import 'package:hknews/widget/CacheImage.dart';

class EPaperItem extends StatefulWidget {
  final EPaper data;

  const EPaperItem({Key key, @required this.data}) : super(key: key);

  @override
  _EPaperItemState createState() {
    return _EPaperItemState();
  }
}

class _EPaperItemState extends State<EPaperItem> {
  _getData() async {
    String a = await getEPaperImageUrl(
        widget.data.publicationCode, widget.data.pubDate);
    setState(() {
      widget.data.image = a;
    });
    return null;
  }

  @override
  void didChangeDependencies() {
    if (widget.data.image.isEmpty) {
      _getData();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        widget.data.image.isEmpty
            ? Image.asset(
                "images/epaper_pic.webp",
                width: MediaQuery.of(context).size.width * 3 / 5,
              )
            : CacheImage.network(
                placeholder: "images/epaper_pic.webp",
                path: widget.data.image,
                width: MediaQuery.of(context).size.width * 3 / 5,
              ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 36.0,
            alignment: Alignment.center,
            child: Text(
              widget.data.publicationName,
              style: TextStyle(color: HKNewsColors.text_black, fontSize: 15.0),
            ),
          ),
        ),
      ],
    );
  }
}
