import 'package:flutter/material.dart';
import 'package:hknews/HKNewsColors.dart';
import 'package:hknews/base/BaseState.dart';
import 'package:hknews/localization/HKNewsLocalizations.dart';
import 'package:hknews/widget/TitleAppBar.dart';
import 'package:hknews/widget/WebView.dart';

class WebPage extends StatefulWidget {
  final String url;

  const WebPage({Key key, this.url}) : super(key: key);

  @override
  _EPaperDetailState createState() {
    return _EPaperDetailState();
  }
}

class _EPaperDetailState extends BaseState<WebPage> {
  @override
  Widget build(BuildContext context) {
    return WebView(
      withJavascript: true,
      url: widget.url,
      scrollBar: false,
      withLocalUrl: true,
      appBar: TitleAppBar(
        context: context,
        title: Text(
          HKNewsLocalizations.of(context).ePaper,
          style: TextStyle(fontSize: 21.0, color: HKNewsColors.text_white),
        ),
        leftIcon: FlatButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Image.asset("images/back.webp"),
        ),
      ),
    );
  }
}
