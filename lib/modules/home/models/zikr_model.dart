class ZikrModel {
  String? categoryId;
  String? categoryName;
  String? categoryLang;
  int? categoryVersion;
  String? categoryBackgroundColor;
  String? categoryTextColor;
  String? categoryImageLink;
  String? categoryImageName;
  String? categoryCreateAt;

  ZikrModel(
      {this.categoryId,
      this.categoryName,
      this.categoryLang,
      this.categoryVersion,
      this.categoryBackgroundColor,
      this.categoryTextColor,
      this.categoryImageLink,
      this.categoryImageName,
      this.categoryCreateAt});

  ZikrModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    categoryLang = json['category_lang'];
    categoryVersion = json['category_version'];
    categoryBackgroundColor = json['category_background_color'];
    categoryTextColor = json['category_text_color'];
    categoryImageLink = json['category_image_link'];
    categoryImageName = json['category_image_name'];
    categoryCreateAt = json['category_create_at'];
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
    zikrModel['category_image_name'] = categoryImageName;
    zikrModel['category_create_at'] = categoryCreateAt;
    return zikrModel;
  }
}
