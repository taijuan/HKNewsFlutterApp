import 'package:flutter/material.dart';
import 'package:hknews/HKNewsColors.dart';

class TitleAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget title;
  final BuildContext context;

  const TitleAppBar({Key key, @required this.context, @required this.title})
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
      child: Center(
        child: widget.title,
      ),
    );
  }
}
