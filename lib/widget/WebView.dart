import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:hknews/base/BaseState.dart';

class WebView extends StatefulWidget {
  final PreferredSizeWidget appBar;
  final String url;
  final bool withJavascript;
  final bool clearCache;
  final bool clearCookies;
  final bool enableAppScheme;
  final String userAgent;
  final bool primary;
  final Widget bottomNavigationBar;
  final bool withZoom;
  final bool withLocalStorage;
  final bool withLocalUrl;
  final bool scrollBar;

  final Map<String, String> headers;

  const WebView(
      {Key key,
      this.appBar,
      @required this.url,
      this.headers,
      this.withJavascript,
      this.clearCache,
      this.clearCookies,
      this.enableAppScheme,
      this.userAgent,
      this.primary = true,
      this.bottomNavigationBar,
      this.withZoom,
      this.withLocalStorage,
      this.withLocalUrl,
      this.scrollBar})
      : super(key: key);

  @override
  _WebViewScaffoldState createState() => new _WebViewScaffoldState();
}

class _WebViewScaffoldState extends BaseState<WebView> {
  final webViewReference = new FlutterWebviewPlugin();
  Rect _rect;
  Timer _resizeTimer;

  @override
  void initState() {
    super.initState();
    webViewReference.close();
  }

  @override
  void dispose() {
    super.dispose();
    webViewReference.close();
    webViewReference.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_rect == null) {
      _rect = _buildRect(context);
      webViewReference.launch(widget.url,
          headers: widget.headers,
          withJavascript: widget.withJavascript,
          clearCache: widget.clearCache,
          clearCookies: widget.clearCookies,
          enableAppScheme: widget.enableAppScheme,
          userAgent: widget.userAgent,
          rect: _rect,
          withZoom: widget.withZoom,
          withLocalStorage: widget.withLocalStorage,
          withLocalUrl: widget.withLocalUrl,
          scrollBar: widget.scrollBar);
    } else {
      final rect = _buildRect(context);
      if (_rect != rect) {
        _rect = rect;
        _resizeTimer?.cancel();
        _resizeTimer = new Timer(new Duration(milliseconds: 300), () {
          // avoid resizing to fast when build is called multiple time
          webViewReference.resize(_rect);
        });
      }
    }
    return new Scaffold(
        appBar: widget.appBar,
        bottomNavigationBar: widget.bottomNavigationBar,
        body: Center(child: const CircularProgressIndicator()));
  }

  Rect _buildRect(BuildContext context) {
    final fullscreen = widget.appBar == null;
    final mediaQuery = MediaQuery.of(context);
    final topPadding = widget.primary ? mediaQuery.padding.top : 0.0;
    double top =
        (fullscreen ? 0.0 : topPadding) + MediaQuery.of(context).padding.top;
    if (widget.appBar != null) {
      top = widget.appBar.preferredSize.height;
    }
    var height = mediaQuery.size.height - top;
    if (widget.bottomNavigationBar != null) {
      height -= 48.0 + mediaQuery.padding.bottom;
    }
    if (height < 0.0) {
      height = 0.0;
    }

    return new Rect.fromLTWH(0.0, top, mediaQuery.size.width, height);
  }
}
