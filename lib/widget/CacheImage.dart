library cache_image;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hknews/base/BaseState.dart';

class CacheImage extends StatefulWidget {
  CacheImage.network({
    Key key,
    this.placeholder,
    this.width,
    this.height,
    this.aspectRatio,
    @required this.path,
  })  : assert(path != null),
        super(key: key);
  final double width;
  final double height;
  final String path;
  final String placeholder;
  final double aspectRatio;

  @override
  State<StatefulWidget> createState() => new _CacheImage();
}

class _CacheImage extends BaseState<CacheImage> {
  @override
  Widget build(BuildContext context) {
    return widget.aspectRatio == null
        ? FadeInImage.assetNetwork(
            fit: BoxFit.cover,
            placeholder: widget.placeholder,
            image: widget.path,
            width: widget.width,
            height: widget.height)
        : AspectRatio(
            aspectRatio: widget.aspectRatio,
            child: FadeInImage.assetNetwork(
              placeholder: widget.placeholder,
              image: widget.path,
              fit: BoxFit.cover,
            ),
          );
  }
}
