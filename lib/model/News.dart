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
  String ytbUrl;

  News.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        image = SERVICE_URL + (json['bigTitleImage'] ?? json["headImage"]),
        publishTime = json['publishTime'],
        jsonUrl = json["jsonUrl"],
        url = SERVICE_URL +
            (json["murl"] ?? json["htmlUrl"]) +
            "?newsId=${json['dataId'].toString()}",
        description = json["description"],
        dataId = json["dataId"],
        dataType = json["dataType"],
        subjectName = json["subjectName"],
        subjectCode = json["subjectCode"],
        txyUrl = json["txyUrl"],
        ytbUrl = json["ytbUrl"];
}
