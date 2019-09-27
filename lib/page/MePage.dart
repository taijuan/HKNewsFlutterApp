import 'package:flutter/material.dart';
import 'package:hknews/HKNewsColors.dart';
import 'package:hknews/base/BaseState.dart';
import 'package:hknews/localization/HKNewsLocalizations.dart';
import 'package:hknews/page/WebPage.dart';
import 'package:hknews/widget/TitleAppBar.dart';

class MePage extends StatefulWidget {
  @override
  _MePageState createState() {
    return _MePageState();
  }
}

class _MePageState extends BaseState<MePage>
    with AutomaticKeepAliveClientMixin<MePage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: HKNewsColors.f5f5f5,
      appBar: TitleAppBar(
        context: context,
        title: Text(
          HKNewsLocalizations.of(context).me,
          style: TextStyle(fontSize: 21.0, color: HKNewsColors.text_white),
        ),
      ),
      body: Builder(
        builder: (context) {
          return ListView(
            children: [
              _buildItem(
                "images/favorite.webp",
                HKNewsLocalizations.of(context).favorite,
                () {
                  showToast(context, HKNewsLocalizations.of(context).favorite);
                },
              ),
              Container(
                height: 8.0,
              ),
              _buildItem(
                "images/facebook.webp",
                HKNewsLocalizations.of(context).facebook,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return WebPage(
                            url:
                                "https://www.facebook.com/chinadailyhkedition/");
                      },
                    ),
                  );
                },
              ),
              Container(
                height: 2.0,
              ),
              _buildItem(
                "images/twitter.webp",
                HKNewsLocalizations.of(context).twitter,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return WebPage(
                            url: "https://twitter.com/chinadailyasia");
                      },
                    ),
                  );
                },
              ),
              Container(
                height: 8.0,
              ),
              _buildItem(
                "images/feedback.webp",
                HKNewsLocalizations.of(context).feedback,
                () {
                  showToast(context, HKNewsLocalizations.of(context).feedback);
                },
              ),
              Container(
                height: 2.0,
              ),
              _buildItem(
                "images/settings.webp",
                HKNewsLocalizations.of(context).settings,
                () {
                  showToast(context, HKNewsLocalizations.of(context).settings);
                },
              )
            ],
          );
        },
      ),
    );
  }

  void showToast(BuildContext context, String msg) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  _buildItem(String icon, String data, onPressed) {
    return FlatButton(
      color: HKNewsColors.text_white,
      padding: EdgeInsets.only(),
      onPressed: onPressed,
      child: Container(
        padding: EdgeInsets.only(left: 12.0, right: 12.0),
        height: 48.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 12.0),
              height: 24.0,
              width: 24.0,
              child: Image.asset(
                icon,
                height: 24.0,
                width: 24.0,
              ),
            ),
            Expanded(
              child: Text(
                data,
                style: TextStyle(
                    color: HKNewsColors.text_black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300),
              ),
            ),
            Image.asset(
              "images/next.webp",
              height: 16.0,
              width: 16.0,
              fit: BoxFit.fitHeight,
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
