class UserFields {
  static const String ordernumber = "ordernumber";
  static const String transactionnumber = "transactionnumber";
  static const String id = "\$id";
}

class DocModel1 {
  double? ordernumber;
  double? transactionnumber;
  String? id;

  DocModel1({
    required this.ordernumber,
    required this.transactionnumber,
    required this.id,
  });

  factory DocModel1.fromJson(Map<dynamic, dynamic> json) {
    return DocModel1(
        id: json[UserFields.id],
        ordernumber: json[UserFields.ordernumber],
        transactionnumber: json[UserFields.transactionnumber]);
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'transactionnumber': transactionnumber,
      'ordernumber': ordernumber,
      'id': id
    };
  }
}
