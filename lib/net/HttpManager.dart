import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:hknews/net/BaseRes.dart';
import 'package:meta/meta.dart';

///http请求
class HttpManager {
  static const String SERVICE_URL = "https://www.chinadailyhk.com";
  static const STATIC_URL = "https://api.cdeclips.com/hknews-api/";
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

  ///发起网络请求
  ///[ url] 请求url
  ///[ params] 请求参数
  ///[ header] 外加头
  ///[ option] 配置
  static get({@required url, params, Map<String, String> header}) async {
    Map<String, String> headers = new HashMap();
    if (header != null) {
      headers.addAll(header);
    }
    var option =
        new Options(method: "get", receiveTimeout: 5000, connectTimeout: 5000);
    option.headers = headers;
    Dio dio = new Dio();
    Response response;
    try {
      response = await dio.request(url, data: params, options: option);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return new BaseRes.fromJson(response.data);
      } else {
        return new BaseRes(null, response.statusCode.toString(), "系统异常");
      }
    } on DioError catch (e) {
      response = e.response;
      int code = response == null ? 666 : response.statusCode;
      return new BaseRes(null, code.toString(), e.message);
    }
  }
}
