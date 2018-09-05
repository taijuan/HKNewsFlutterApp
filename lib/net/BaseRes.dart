class BaseRes extends Object {
  dynamic resObject;
  String resCode;
  String resMsg;

  BaseRes(this.resObject, this.resCode, this.resMsg);

  BaseRes.fromJson(Map<String, dynamic> json)
      : resObject = json['resObject'] ?? json["newestPubDate"] ?? json["data"],
        resCode = json['resCode'] ?? "200",
        resMsg = json['resMsg'] ?? "success";

  Map<String, dynamic> toJson() => {
        'resObject': resObject,
        'resCode': resCode,
        'resMsg': resMsg,
      };
}
