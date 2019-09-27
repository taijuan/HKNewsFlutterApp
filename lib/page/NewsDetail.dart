import 'package:flutter/material.dart';
import 'package:hknews/base/BaseState.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetail extends StatefulWidget {
  final String url;

  const NewsDetail({Key key, @required this.url}) : super(key: key);

  @override
  _NewsDetailState createState() {
    return _NewsDetailState();
  }
}

class _NewsDetailState extends BaseState<NewsDetail> {
  @override
  void initState() {
    print(widget.url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
      bottomNavigationBar: Container(
        height: 48.0,
        child: Row(
          children: <Widget>[
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
                  ),
                ),
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
