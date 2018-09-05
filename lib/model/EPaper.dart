import 'package:hknews/model/Api.dart';

class EPaper {
  final String publicationCode;
  final String publicationName;
  final String pubDate;
  final int isHide;
  String image = "";
  String ePaperUrl;

  EPaper(this.publicationCode, this.publicationName, this.pubDate, this.isHide);

  EPaper.fromJson(Map<String, dynamic> json)
      : publicationCode = json["publicationCode"],
        publicationName = json["publicationName"],
        pubDate = json["pubDate"].toString().replaceAll("-", "/"),
        isHide = json["publicationConfig"]["isHide"],
        ePaperUrl =
            "${E_PAPER_URL}mobile/index.html?pubCode=${json["publicationCode"]}&pubDate=${json["pubDate"]}";
}
