class TapesModel {
  int? status;
  String? message;
  Zikr? zikr;
  Dua? dua;
  Verse? verse;
  Name? name;
  List<News>? news;

  TapesModel(
      {this.status,
      this.message,
      this.zikr,
      this.dua,
      this.verse,
      this.name,
      this.news});

  TapesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    zikr = json['zikr'] != null ? Zikr.fromJson(json['zikr']) : null;
    dua = json['dua'] != null ? Dua.fromJson(json['dua']) : null;
    verse = json['verse'] != null ? Verse.fromJson(json['verse']) : null;
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    if (json['news'] != null) {
      news = <News>[];
      json['news'].forEach((v) {
        news!.add(News.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (zikr != null) {
      data['zikr'] = zikr!.toJson();
    }
    if (dua != null) {
      data['dua'] = dua!.toJson();
    }
    if (verse != null) {
      data['verse'] = verse!.toJson();
    }
    if (name != null) {
      data['name'] = name!.toJson();
    }
    if (news != null) {
      data['news'] = news!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Zikr {
  String? zikrId;
  String? zikrTitle;
  String? zikrDescription;
  String? zikrInfo;
  int? zikrDailyCount;
  String? zikrAudioLink;
  String? zikrAudioName;
  int? favouriteCount;
  String? categoryId;
  String? zikrCreateAt;

  Zikr(
      {this.zikrId,
      this.zikrTitle,
      this.zikrDescription,
      this.zikrInfo,
      this.zikrDailyCount,
      this.zikrAudioLink,
      this.zikrAudioName,
      this.favouriteCount,
      this.categoryId,
      this.zikrCreateAt});

  Zikr.fromJson(Map<String, dynamic> json) {
    zikrId = json['zikr_id'];
    zikrTitle = json['zikr_title'];
    zikrDescription = json['zikr_description'];
    zikrInfo = json['zikr_info'];
    zikrDailyCount = json['zikr_daily_count'];
    zikrAudioLink = json['zikr_audio_link'];
    zikrAudioName = json['zikr_audio_name'];
    favouriteCount = json['favourite_count'];
    categoryId = json['category_id'];
    zikrCreateAt = json['zikr_create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['zikr_id'] = zikrId;
    data['zikr_title'] = zikrTitle;
    data['zikr_description'] = zikrDescription;
    data['zikr_info'] = zikrInfo;
    data['zikr_daily_count'] = zikrDailyCount;
    data['zikr_audio_link'] = zikrAudioLink;
    data['zikr_audio_name'] = zikrAudioName;
    data['favourite_count'] = favouriteCount;
    data['category_id'] = categoryId;
    data['zikr_create_at'] = zikrCreateAt;
    return data;
  }
}

class Dua {
  String? zikrId;
  String? zikrTitle;
  String? zikrDescription;
  String? zikrInfo;
  int? zikrDailyCount;
  String? zikrAudioLink;
  String? zikrAudioName;
  int? favouriteCount;
  String? categoryId;
  String? zikrCreateAt;

  Dua(
      {this.zikrId,
      this.zikrTitle,
      this.zikrDescription,
      this.zikrInfo,
      this.zikrDailyCount,
      this.zikrAudioLink,
      this.zikrAudioName,
      this.favouriteCount,
      this.categoryId,
      this.zikrCreateAt});

  Dua.fromJson(Map<String, dynamic> json) {
    zikrId = json['zikr_id'];
    zikrTitle = json['zikr_title'];
    zikrDescription = json['zikr_description'];
    zikrInfo = json['zikr_info'];
    zikrDailyCount = json['zikr_daily_count'];
    zikrAudioLink = json['zikr_audio_link'];
    zikrAudioName = json['zikr_audio_name'];
    favouriteCount = json['favourite_count'];
    categoryId = json['category_id'];
    zikrCreateAt = json['zikr_create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['zikr_id'] = zikrId;
    data['zikr_title'] = zikrTitle;
    data['zikr_description'] = zikrDescription;
    data['zikr_info'] = zikrInfo;
    data['zikr_daily_count'] = zikrDailyCount;
    data['zikr_audio_link'] = zikrAudioLink;
    data['zikr_audio_name'] = zikrAudioName;
    data['favourite_count'] = favouriteCount;
    data['category_id'] = categoryId;
    data['zikr_create_at'] = zikrCreateAt;
    return data;
  }
}

class Verse {
  String? verseId;
  int? verseNumber;
  int? juzNumber;
  String? juzDividerText;
  int? suraId;
  String? verseArabic;
  String? text;
  String? meaning;
  String? verseCreateAt;

  Verse(
      {this.verseId,
      this.verseNumber,
      this.juzNumber,
      this.juzDividerText,
      this.suraId,
      this.verseArabic,
      this.text,
      this.meaning,
      this.verseCreateAt});

  Verse.fromJson(Map<String, dynamic> json) {
    verseId = json['verse_id'];
    verseNumber = json['verse_number'];
    juzNumber = json['juz_number'];
    juzDividerText = json['juz_divider_text'];
    suraId = json['sura_id'];
    verseArabic = json['verse_arabic'];
    text = json['text'];
    meaning = json['meaning'];
    verseCreateAt = json['verse_create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['verse_id'] = verseId;
    data['verse_number'] = verseNumber;
    data['juz_number'] = juzNumber;
    data['juz_divider_text'] = juzDividerText;
    data['sura_id'] = suraId;
    data['verse_arabic'] = verseArabic;
    data['text'] = text;
    data['meaning'] = meaning;
    data['verse_create_at'] = verseCreateAt;
    return data;
  }
}

class Name {
  String? nameId;
  String? nameArabic;
  String? title;
  String? description;
  String? translation;
  String? nameAudioLink;
  String? nameAudioName;
  String? nameCreateAt;

  Name(
      {this.nameId,
      this.nameArabic,
      this.title,
      this.description,
      this.translation,
      this.nameAudioLink,
      this.nameAudioName,
      this.nameCreateAt});

  Name.fromJson(Map<String, dynamic> json) {
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

class News {
  String? newsId;
  String? newsTitle;
  String? newsDescription;
  String? newsButtonText;
  String? newsLink;
  String? newsLang;
  String? newsImageLink;
  String? newsImageName;
  int? newsLike;
  int? newsViews;
  bool? newsActive;
  String? newsCreateAt;

  News(
      {this.newsId,
      this.newsTitle,
      this.newsDescription,
      this.newsButtonText,
      this.newsLink,
      this.newsLang,
      this.newsImageLink,
      this.newsImageName,
      this.newsLike,
      this.newsViews,
      this.newsActive,
      this.newsCreateAt});

  News.fromJson(Map<String, dynamic> json) {
    newsId = json['news_id'];
    newsTitle = json['news_title'];
    newsDescription = json['news_description'];
    newsButtonText = json['news_button_text'];
    newsLink = json['news_link'];
    newsLang = json['news_lang'];
    newsImageLink = json['news_image_link'];
    newsImageName = json['news_image_name'];
    newsLike = json['news_like'];
    newsViews = json['news_views'];
    newsActive = json['news_active'];
    newsCreateAt = json['news_create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['news_id'] = newsId;
    data['news_title'] = newsTitle;
    data['news_description'] = newsDescription;
    data['news_button_text'] = newsButtonText;
    data['news_link'] = newsLink;
    data['news_lang'] = newsLang;
    data['news_image_link'] = newsImageLink;
    data['news_image_name'] = newsImageName;
    data['news_like'] = newsLike;
    data['news_views'] = newsViews;
    data['news_active'] = newsActive;
    data['news_create_at'] = newsCreateAt;
    return data;
  }
}
