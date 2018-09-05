import 'package:meta/meta.dart';

export 'package:hknews/net/BaseRes.dart';

class BaseData<A, B> {
  final bool isSuccess;
  final A a;
  final B b;

  const BaseData({@required this.isSuccess, this.a, this.b});
}
