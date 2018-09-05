import 'package:flutter/material.dart';
import 'package:hknews/HKNewsColors.dart';
import 'package:hknews/localization/HKNewsLocalizations.dart';
import 'package:hknews/widget/EPaperTitleAppBar.dart';
import 'package:hknews/widget/WebView.dart';

class EPaperDetail extends StatefulWidget {
  final String url;

  const EPaperDetail({Key key, this.url}) : super(key: key);

  @override
  _EPaperDetailState createState() {
    return _EPaperDetailState();
  }
}

class _EPaperDetailState extends State<EPaperDetail> {
  @override
  Widget build(BuildContext context) {
    return WebView(
      withJavascript: true,
      url: widget.url,
      scrollBar: false,
      withLocalUrl: true,
      appBar: EPaperTitleAppBar(
        context: context,
        title: Text(
          HKNewsLocalizations.of(context).ePaper,
          style: TextStyle(fontSize: 21.0, color: HKNewsColors.text_black),
        ),
      ),
    );
  }
}
