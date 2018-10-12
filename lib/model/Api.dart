import 'dart:convert';

import 'package:hknews/model/BaseData.dart';
import 'package:hknews/model/EPaper.dart';
import 'package:hknews/model/News.dart';
import 'package:hknews/net/BaseRes.dart';
import 'package:hknews/net/Code.dart';
import 'package:hknews/net/HttpManager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const SERVICE_URL = "https://www.chinadailyhk.com";
const STATIC_URL = "https://api.cdeclips.com/hknews-api/";
const E_PAPER_URL = "https://epaperlib.chinadailyhk.com/";

Future<BaseData<List<News>, Null>> getNewsData(String name, int curPage) async {
  var url =
      "${STATIC_URL}selectNewsList?subjectCode=$name&currentPage=$curPage&dataType=1";
  BaseRes res = await HttpManager.get(url: url);
  logRes(name, res);
  BaseData<List<News>, Null> data;
  if (Code.isSuccessful(res.resCode)) {
    var _a = res.resObject['dateList'];
    List<News> a = [];
    for (var value in _a) {
      a.add(News.fromJson(value));
    }
    data = BaseData(isSuccess: true, a: a);
    if (curPage == 1) {
      var _instance = await SharedPreferences.getInstance();
      await _instance.setString(name, json.encode(_a));
    }
  } else {
    if (curPage == 1) {
      var _instance = await SharedPreferences.getInstance();
      var _a = json.decode(_instance.getString(name));
      if (_a == null) {
        data = BaseData(isSuccess: false, a: []);
      } else {
        List<News> a = [];
        for (var value in _a) {
          a.add(News.fromJson(value));
        }
        data = BaseData(isSuccess: false, isCache: true, a: a);
      }
    } else {
      data = BaseData(isSuccess: false, a: []);
    }
  }
  return data;
}

void logRes(String name, BaseRes res) {
  print("$name =============== $name");
  print(res.resCode);
  print(res.resMsg);
  print(res.resObject);
  print("$name =============== $name");
}

Future<BaseData<List<News>, Null>> getVideoData(int curPage) async {
  var url = STATIC_URL + "selectNewsList?currentPage=$curPage&dataType=3";
  BaseRes res = await HttpManager.get(url: url);
  logRes("video", res);
  BaseData<List<News>, Null> data;
  if (Code.isSuccessful(res.resCode)) {
    var _a = res.resObject['dateList'];
    List<News> a = [];
    for (var value in _a) {
      a.add(News.fromJson(value));
    }
    data = BaseData(isSuccess: true, a: a);
    if (curPage == 1) {
      var _instance = await SharedPreferences.getInstance();
      await _instance.setString("video", json.encode(_a));
    }
  } else {
    if (curPage == 1) {
      var _instance = await SharedPreferences.getInstance();
      var _a = json.decode(_instance.getString("video"));
      if (_a == null) {
        data = BaseData(isSuccess: false, a: []);
      } else {
        List<News> a = [];
        for (var value in _a) {
          a.add(News.fromJson(value));
        }
        data = BaseData(isSuccess: false, isCache: true, a: a);
      }
    } else {
      data = BaseData(isSuccess: false, a: []);
    }
  }
  return data;
}

Future<BaseData<List<News>, Null>> getLastVideo(String subjectCode) async {
  var url = STATIC_URL +
      "selectNewsList?subjectCode=$subjectCode&currentPage=1&dataType=3";
  BaseRes res = await HttpManager.get(url: url);
  logRes("video", res);
  BaseData<List<News>, Null> data;
  if (Code.isSuccessful(res.resCode)) {
    var _a = res.resObject['dateList'];
    List<News> a = [];
    for (var value in _a) {
      a.add(News.fromJson(value));
    }
    data = BaseData(isSuccess: true, a: a);
  } else {
    data = BaseData(isSuccess: false, a: []);
  }
  return data;
}

Future<BaseData<List<News>, List<News>>> getHotNewsData() async {
  var url = STATIC_URL + "homeDataNewsList";
  BaseRes res = await HttpManager.get(url: url);
  logRes("home", res);
  bool isSuccess = Code.isSuccessful(res.resCode);
  if (isSuccess) {
    var _instance = await SharedPreferences.getInstance();
    await _instance.setString(
        "allLists", json.encode(res.resObject['allLists']));
    await _instance.setString(
        "top_focus", json.encode(res.resObject['top_focus']));
  }
  var _instance = await SharedPreferences.getInstance();
  var _a = json.decode(_instance.getString("allLists"));
  var _b = json.decode(_instance.getString("top_focus"));
  List<News> a = [];
  if (_a != null) {
    for (var value in _a) {
      a.add(News.fromJson(value));
    }
  }
  List<News> b = [];
  if (_b != null) {
    for (var value in _b) {
      b.add(News.fromJson(value));
    }
  }
  return BaseData<List<News>, List<News>>(
      isSuccess: isSuccess, isCache: !isSuccess, a: a, b: b);
}

Future<BaseData<List<EPaper>, Null>> getEPaperData() async {
  BaseRes res = await HttpManager.get(url: "${E_PAPER_URL}pubs/config.json");
  logRes("epaper", res);
  bool isSuccess = Code.isSuccessful(res.resCode);
  if (isSuccess) {
    var _instance = await SharedPreferences.getInstance();
    await _instance.setString("epaper", json.encode(res.resObject));
  }
  var _instance = await SharedPreferences.getInstance();
  var _a = json.decode(_instance.getString("epaper") ?? "");
  List<EPaper> a = [];
  if (_a != null) {
    for (var value in _a) {
      EPaper ePaper = EPaper.fromJson(value);
      if (ePaper.isHide == 0) {
        a.add(ePaper);
      }
    }
  }
  return BaseData<List<EPaper>, Null>(
      isSuccess: a.isNotEmpty, isCache: !isSuccess, a: a);
}

Future<String> getEPaperImageUrl(String publicationCode, String pubDate) async {
  String url = "${E_PAPER_URL}pubs/$publicationCode/$pubDate/issue.json";
  BaseRes res = await HttpManager.get(url: url);
  if (Code.isSuccessful(res.resCode)) {
    var _instance = await SharedPreferences.getInstance();
    await _instance.setString(
        url, "${E_PAPER_URL}pubs${res.resObject[0]["snapshotBigUrl"]}");
  }
  var _instance = await SharedPreferences.getInstance();
  return _instance.getString(url) ?? "";
}

Future<String> getVideoDetail(String dataId) async {
  BaseRes res =
      await HttpManager.get(url: "${STATIC_URL}selecNewsDetail?dataId=$dataId");
  if (Code.isSuccessful(res.resCode)) {
    return News.fromJson(res.resObject)?.txyUrl ?? "";
  }
  return "";
}

Future<int> getLikes(String dataId) async {
  BaseRes res =
      await HttpManager.get(url: "${STATIC_URL}searchLike?newsId=$dataId");
  logRes("getLikes", res);
  if (Code.isSuccessful(res.resCode)) {
    return res.resObject["count"] ?? 0;
  }
  return 0;
}
