import 'package:hknews/model/BaseData.dart';
import 'package:hknews/model/EPaper.dart';
import 'package:hknews/model/News.dart';
import 'package:hknews/net/BaseRes.dart';
import 'package:hknews/net/Code.dart';
import 'package:hknews/net/HttpManager.dart';

const SERVICE_URL = "https://www.chinadailyhk.com";
const STATIC_URL = "https://api.cdeclips.com/hknews-api/";
const E_PAPER_URL = "https://epaperlib.chinadailyhk.com/";

getNewsData(String name, int curPage) async {
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
  } else {
    data = BaseData(isSuccess: false, a: []);
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

getVideoData(int curPage) async {
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
  } else {
    data = BaseData(isSuccess: false, a: []);
  }
  return data;
}

getLastVideo(String subjectCode) async {
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

getHotNewsData() async {
  var url = STATIC_URL + "homeDataNewsList";
  BaseRes res = await HttpManager.get(url: url);
  logRes("home", res);
  BaseData<List<News>, List<News>> data;
  if (Code.isSuccessful(res.resCode)) {
    var _a = res.resObject['allLists'];
    List<News> a = [];
    for (var value in _a) {
      a.add(News.fromJson(value));
    }
    var _b = res.resObject['top_focus'];
    List<News> b = [];
    for (var value in _b) {
      b.add(News.fromJson(value));
    }
    data = BaseData(isSuccess: true, a: a, b: b);
  } else {
    data = BaseData(isSuccess: false, a: [], b: []);
  }
  return data;
}

getEPaperData() async {
  BaseRes res = await HttpManager.get(url: "${E_PAPER_URL}pubs/config.json");
  logRes("epaper", res);
  BaseData<List<EPaper>, Null> data;
  if (Code.isSuccessful(res.resCode)) {
    List<EPaper> a = [];
    var _a = res.resObject;
    for (var value in _a) {
      EPaper ePaper = EPaper.fromJson(value);
      if (ePaper.isHide == 0) {
        a.add(ePaper);
      }
    }
    data = BaseData(isSuccess: true, a: a);
  } else {
    data = BaseData(isSuccess: false, a: []);
  }
  return data;
}

getEPaperImageUrl(String publicationCode, String pubDate) async {
  BaseRes res = await HttpManager.get(
      url: "${E_PAPER_URL}pubs/$publicationCode/$pubDate/issue.json");
  if (Code.isSuccessful(res.resCode)) {
    return "${E_PAPER_URL}pubs${res.resObject[0]["snapshotBigUrl"]}";
  }
  return "";
}

getVideoDetail(String dataId) async {
  BaseRes res =
      await HttpManager.get(url: "${STATIC_URL}selecNewsDetail?dataId=$dataId");
  if (Code.isSuccessful(res.resCode)) {
    return News.fromJson(res.resObject)?.txyUrl ?? "";
  }
  return "";
}

getLikes(String dataId) async {
  BaseRes res =
      await HttpManager.get(url: "${STATIC_URL}searchLike?newsId=$dataId");
  logRes("getLikes", res);
  if (Code.isSuccessful(res.resCode)) {
    return res.resObject["count"] ?? 0;
  }
  return 0;
}
