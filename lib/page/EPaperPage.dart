import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hknews/model/Api.dart';
import 'package:hknews/model/BaseData.dart';
import 'package:hknews/model/EPaper.dart';
import 'package:hknews/page/WebPage.dart';
import 'package:hknews/widget/EPaperItem.dart';

class EPaperPage extends StatefulWidget {
  @override
  _EPaperPageState createState() {
    return _EPaperPageState();
  }
}

class _EPaperPageState extends State<EPaperPage>
    with AutomaticKeepAliveClientMixin<EPaperPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  List<EPaper> _data = [];

  Future<Null> handleRefresh() async {
    await _getData();
    return null;
  }

  Future _getData() async {
    BaseData<List<EPaper>, Null> data = await getEPaperData();
    if (data.isSuccess && data.a.isNotEmpty) {
      setState(() {
        _data.clear();
        _data.addAll(data.a);
        print("${widget.toString()}    ${_data.length.toString()}");
      });
    }
  }

  showRefreshLoading() {
    new Future.delayed(const Duration(seconds: 0), () {
      _refreshIndicatorKey.currentState.show().then((e) {});
      return true;
    });
  }

  @override
  void didChangeDependencies() {
    print("${widget.toString()} didChangeDependencies");
    if (_data.isEmpty) {
      handleRefresh();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "images/epaper_background.webp",
          fit: BoxFit.fill,
          height: 260.0,
        ),
        Container(
          height: 260.0,
          padding: EdgeInsets.only(left: 36.0, right: 36.0, bottom: 24.0),
          alignment: Alignment.center,
          child: Image.asset(
            "images/epaper_textimg.webp",
          ),
        ),
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: 200.0),
          child: PageView(
            controller: PageController(viewportFraction: 0.7),
            children: _data.map((value) {
              return Stack(
                children: <Widget>[
                  EPaperItem(data: value),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return WebPage(url: value.ePaperUrl);
                      }));
                    },
                    child: Container(),
                  ),
                ],
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
