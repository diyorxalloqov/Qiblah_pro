class ZikrCategoryModel {
  String? categoryId;
  String? categoryName;
  String? categoryLang;
  int? categoryVersion;
  String? categoryBackgroundColor;
  String? categoryTextColor;
  String? categoryImageLink;

  ZikrCategoryModel(
      {this.categoryId,
      this.categoryName,
      this.categoryLang,
      this.categoryVersion,
      this.categoryBackgroundColor,
      this.categoryTextColor,
      this.categoryImageLink});

  ZikrCategoryModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    categoryLang = json['category_lang'];
    categoryVersion = json['category_version'];
    categoryBackgroundColor = json['category_background_color'];
    categoryTextColor = json['category_text_color'];
    categoryImageLink = json['category_image_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> zikrModel = <String, dynamic>{};
    zikrModel['category_id'] = categoryId;
    zikrModel['category_name'] = categoryName;
    zikrModel['category_lang'] = categoryLang;
    zikrModel['category_version'] = categoryVersion;
    zikrModel['category_background_color'] = categoryBackgroundColor;
    zikrModel['category_text_color'] = categoryTextColor;
    zikrModel['category_image_link'] = categoryImageLink;
    return zikrModel;
  }
}

// //////////////////////

class ZikrModel {
  String? zikrId;
  String? zikrTitle;
  String? zikrDescription;
  String? zikrInfo;
  int? zikrDailyCount;
  String? zikrAudioLink;
  int? favouriteCount;
  String? categoryId;
  String? categoryName;
  String? categoryLang;
  int? categoryVersion;
  String? zikrAudioName;
  bool? isSaved;
  int? allZikrs;
  int? todayZikrs;

  ZikrModel(
      {this.zikrId,
      this.zikrTitle,
      this.zikrDescription,
      this.zikrInfo,
      this.zikrDailyCount,
      this.zikrAudioLink,
      this.favouriteCount,
      this.categoryId,
      this.isSaved = false,
      this.zikrAudioName,
      this.categoryName,
      this.categoryLang,
      this.allZikrs = 0,
      this.todayZikrs = 0,
      this.categoryVersion});

  ZikrModel.fromJson(Map<String, dynamic> json) {
    zikrId = json['zikr_id'];
    zikrTitle = json['zikr_title'];
    zikrDescription = json['zikr_description'];
    zikrInfo = json['zikr_info'];
    zikrDailyCount = json['zikr_daily_count'];
    zikrAudioLink = json['zikr_audio_link'];
    favouriteCount = json['favourite_count'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    categoryLang = json['category_lang'];
    categoryVersion = json['category_version'];
    zikrAudioName = json['zikr_audio_name'];
    isSaved = json['isSaved'] == 1;
    allZikrs = json['all_zikrs'] ?? 0;
    todayZikrs = json['today_zikrs'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['zikr_id'] = zikrId;
    data['zikr_title'] = zikrTitle;
    data['zikr_description'] = zikrDescription;
    data['zikr_info'] = zikrInfo;
    data['zikr_daily_count'] = zikrDailyCount;
    data['zikr_audio_link'] = zikrAudioLink;
    data['favourite_count'] = favouriteCount;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['category_lang'] = categoryLang;
    data['category_version'] = categoryVersion;
    data['zikr_audio_name'] = zikrAudioName;
    data['isSaved'] = isSaved ?? false ? 1 : 0;
    data['all_zikrs'] = allZikrs ?? 0;
    data['today_zikrs'] = todayZikrs ?? 0;
    return data;
  }
}
