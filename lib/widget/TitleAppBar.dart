import 'package:flutter/material.dart';
import 'package:hknews/HKNewsColors.dart';

class TitleAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget title;
  final Widget leftIcon;
  final Widget rightIcon;
  final BuildContext context;

  const TitleAppBar(
      {Key key,
      @required this.context,
      @required this.title,
      this.leftIcon,
      this.rightIcon})
      : super(key: key);

  @override
  Size get preferredSize =>
      Size.fromHeight(48.0 + MediaQuery.of(context).padding.top);

  @override
  _TitleAppBarState createState() {
    return _TitleAppBarState();
  }
}

class _TitleAppBarState extends State<TitleAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      foregroundDecoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: HKNewsColors.grey_light),
        ),
      ),
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            HKNewsColors.blue_light,
            HKNewsColors.blue_black,
            HKNewsColors.blue_black,
          ],
        ),
      ),
      height: 48.0 + MediaQuery.of(context).padding.top,
      child: Row(
        children: <Widget>[
          Container(
            width: 48.0,
            height: 48.0,
            child: widget.leftIcon,
          ),
          Expanded(
            child: Center(
              child: widget.title,
            ),
          ),
          Container(
            width: 48.0,
            height: 48.0,
            child: widget.rightIcon,
          )
        ],
      ),
    );
  }
}
