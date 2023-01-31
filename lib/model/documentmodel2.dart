class UserFields {
  static const String productnumber = "productnumber";
  static const String id = "\$id";
}

class DocModel2 {
  int? productnumber;
  String? id;

  DocModel2({
    required this.productnumber,
    required this.id,
  });

  factory DocModel2.fromJson(Map<dynamic, dynamic> json) {
    return DocModel2(
        id: json[UserFields.id], productnumber: json[UserFields.productnumber]);
  }

  Map<dynamic, dynamic> toJson() {
    return {'productnumber': productnumber, 'id': id};
  }
}
