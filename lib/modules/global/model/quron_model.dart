class QuronModel {
  int? status;
  String? message;
  List<Data>? data;

  QuronModel({this.status, this.message, this.data});

  QuronModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? suraId;
  String? suraNameArabic;
  String? name;
  int? suraVerseCount;
  int? suraFrom;
  String? suraCreateAt;

  Data(
      {this.suraId,
      this.suraNameArabic,
      this.name,
      this.suraVerseCount,
      this.suraFrom,
      this.suraCreateAt});

  Data.fromJson(Map<String, dynamic> json) {
    suraId = json['sura_id'];
    suraNameArabic = json['sura_name_arabic'];
    name = json['name'];
    suraVerseCount = json['sura_verse_count'];
    suraFrom = json['sura_from'];
    suraCreateAt = json['sura_create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sura_id'] = suraId;
    data['sura_name_arabic'] = suraNameArabic;
    data['name'] = name;
    data['sura_verse_count'] = suraVerseCount;
    data['sura_from'] = suraFrom;
    data['sura_create_at'] = suraCreateAt;
    return data;
  }
}
