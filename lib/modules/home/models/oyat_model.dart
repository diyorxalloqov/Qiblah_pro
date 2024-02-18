class OyatModel {
  String? verseId;
  int? suraNumber;
  int? verseNumber;
  int? juzNumber;
  String? juzDividerText;
  int? suraId;
  String? verseArabic;
  String? text;
  String? meaning;
  String? verseCreateAt;
  int? id;

  OyatModel({
    this.verseId,
    this.id,
    this.suraNumber,
    this.verseNumber,
    this.juzNumber,
    this.juzDividerText,
    this.suraId,
    this.verseArabic,
    this.text,
    this.meaning,
    this.verseCreateAt,
  });

  OyatModel.fromJson(Map<String, dynamic> json)
      : verseId = json['verse_id'],
        id = json['id'],
        suraNumber = json['sura_number'],
        verseNumber = json['verse_number'],
        juzNumber = json['juz_number'],
        suraId = json['sura_id'],
        verseArabic = json['verse_arabic'],
        text = json['text'],
        meaning = json['meaning'],
        verseCreateAt = json['verse_create_at'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['verse_id'] = verseId;
    data['sura_number'] = suraNumber;
    data['verse_number'] = verseNumber;
    data['juz_number'] = juzNumber;
    data['sura_id'] = suraId;
    data['verse_arabic'] = verseArabic;
    data['text'] = text;
    data['meaning'] = meaning;
    data['verse_create_at'] = verseCreateAt;
    return data;
  }
}
