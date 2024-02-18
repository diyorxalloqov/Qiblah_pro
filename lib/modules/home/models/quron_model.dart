class QuronModel {
  String? suraId;
  String? suraNameArabic;
  String? name;
  int? suraVerseCount;
  int? suraFrom;
  String? suraCreateAt;

  QuronModel(
      {this.suraId,
      this.suraNameArabic,
      this.name,
      this.suraVerseCount,
      this.suraFrom,
      this.suraCreateAt});

  QuronModel.fromJson(Map<String, dynamic> json) {
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
