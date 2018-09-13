import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hknews/model/Api.dart';
import 'package:hknews/model/News.dart';
import 'package:hknews/widget/CacheImage.dart';
import 'package:video_player/video_player.dart';

class HeaderVideoTitleBar extends StatefulWidget
    implements PreferredSizeWidget {
  final BuildContext context;
  final News data;

  const HeaderVideoTitleBar(
      {Key key, @required this.context, @required this.data})
      : super(key: key);

  @override
  _HeaderVideoTitleBarState createState() {
    return _HeaderVideoTitleBarState();
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(MediaQuery.of(context).size.width * 9 / 16);
  }
}

class _HeaderVideoTitleBarState extends State<HeaderVideoTitleBar> {
  VideoPlayerController _controller;
  bool _isPlaying = false;

  initPlayer(String url) {
    _controller = VideoPlayerController.network(url);
    _controller.setLooping(true);
    _controller.addListener(() {
      final bool isPlaying = _controller.value.isPlaying;
      if (isPlaying != _isPlaying) {
        _isPlaying = isPlaying;
        setState(() {});
      }
    });
    _controller.initialize().then((_) {
      setState(() {});
    });
  }

  _getData() async {
    String url = await getVideoDetail(widget.data.dataId);
    if (url.isNotEmpty) {
      initPlayer(url);
    }
  }

  @override
  void didChangeDependencies() {
    if (_controller == null) {
      _getData();
    }
    super.didChangeDependencies();
  }

  bool isPlayerInit() {
    return _controller?.value?.initialized ?? false;
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          isPlayerInit() ? VideoPlayer(_controller) : Container(),
          isPlayerInit()
              ? VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                )
              : Container(),
          isPlayerInit()
              ? FlatButton(
                  onPressed: onPressed,
                  child: Container(),
                )
              : CacheImage.network(
                  aspectRatio: 16 / 9,
                  path: widget.data.image,
                  placeholder: "images/placeholder.webp",
                ),
        ],
      ),
    );
  }

  Future<void> onPressed() {
    if (isPlayerInit()) {
      return _controller.value.isPlaying
          ? _controller.pause()
          : _controller.play();
    } else {
      return null;
    }
  }
}
