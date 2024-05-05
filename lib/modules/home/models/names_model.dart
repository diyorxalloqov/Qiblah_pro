class NamesData {
  String? nameId;
  String? nameArabic;
  String? title;
  String? description;
  String? translation;
  String? nameAudioLink;
  String? nameAudioName;
  String? nameCreateAt;

  NamesData(
      {this.nameId,
      this.nameArabic,
      this.title,
      this.description,
      this.translation,
      this.nameAudioLink,
      this.nameAudioName,
      this.nameCreateAt});

  NamesData.fromJson(Map<String, dynamic> json) {
    nameId = json['name_id'];
    nameArabic = json['name_arabic'];
    title = json['title'];
    description = json['description'];
    translation = json['translation'];
    nameAudioLink = json['name_audio_link'];
    nameAudioName = json['name_audio_name'];
    nameCreateAt = json['name_create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name_id'] = nameId;
    data['name_arabic'] = nameArabic;
    data['title'] = title;
    data['description'] = description;
    data['translation'] = translation;
    data['name_audio_link'] = nameAudioLink;
    data['name_audio_name'] = nameAudioName;
    data['name_create_at'] = nameCreateAt;
    return data;
  }
}
