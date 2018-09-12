import 'package:flutter/widgets.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}
