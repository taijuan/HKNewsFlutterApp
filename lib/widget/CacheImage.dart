library cache_image;

import 'package:cached_network_image/cached_network_image.dart';
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
        ? CachedNetworkImage(
            fit: BoxFit.cover,
            placeholder: Image.asset(widget.placeholder),
            imageUrl: widget.path,
            width: widget.width,
            height: widget.height)
        : AspectRatio(
            aspectRatio: widget.aspectRatio,
            child: CachedNetworkImage(
              placeholder: Image.asset(widget.placeholder),
              imageUrl: widget.path,
              fit: BoxFit.cover,
            ),
          );
  }
}
