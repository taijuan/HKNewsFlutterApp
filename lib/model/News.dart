import 'package:hknews/model/Api.dart';

class News {
  String title;

  /// headImage or bigTitleImage
  String image;
  String publishTime;
  String jsonUrl;

  /// htmlUrl or murl
  String url;
  String description;
  String dataId;
  int dataType;
  String subjectName;
  String subjectCode;
  String txyUrl;

  News.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? "";
    image = (json['bigTitleImage'] ?? json["headImage"] ?? "");
    image.replaceAll("//www.chinadailyhk.com", "");
    image = SERVICE_URL + image;
    publishTime = json['publishTime'] ?? "";
    jsonUrl = json["jsonUrl"] ?? "";
    url = SERVICE_URL +
        (json["murl"] ?? json["htmlUrl"]) +
        "?newsId=${json['dataId'].toString()}";
    description = json["description"] ?? "";
    dataId = json["dataId"] ?? "";
    dataType = json["dataType"] ?? 0;
    subjectName = json["subjectName"] ?? "";
    subjectCode = json["subjectCode"] ?? "";
    txyUrl = json["txyUrl"] ?? "";
  }
}
