import 'package:flutter/material.dart';
import 'package:hknews/HKNewsColors.dart';

class EPaperTitleAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget title;
  final BuildContext context;

  const EPaperTitleAppBar(
      {Key key, @required this.context, @required this.title})
      : super(key: key);

  @override
  Size get preferredSize =>
      Size.fromHeight(48.0 + MediaQuery.of(context).padding.top);

  @override
  _EPaperTitleAppBarState createState() {
    return _EPaperTitleAppBarState();
  }
}

class _EPaperTitleAppBarState extends State<EPaperTitleAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      foregroundDecoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: HKNewsColors.grey_light),
        ),
      ),
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      height: 48.0 + MediaQuery.of(context).padding.top,
      child: Stack(
        children: <Widget>[
          Center(
            child: widget.title,
          ),
          Container(
            width: 48.0,
            height: 48.0,
            child: FlatButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Center(
                child: Image.asset(
                  "images/back.webp",
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
