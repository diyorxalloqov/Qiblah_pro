class NamozModel {
  String? categoryName;
  String? gender;
  String? description;
  String? titleColor;
  String? descriptionColor;
  String? image;
  String? backgroundColor;
  String? typeIsBig;
  List<CategoryItems>? categoryItems;

  NamozModel(
      {this.categoryName,
      this.gender,
      this.description,
      this.titleColor,
      this.descriptionColor,
      this.image,
      this.backgroundColor,
      this.typeIsBig,
      this.categoryItems});

  NamozModel.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    gender = json['gender'];
    description = json['description'];
    titleColor = json['title_color'];
    descriptionColor = json['description_color'];
    image = json['image'];
    backgroundColor = json['background_color'];
    typeIsBig = json['type_is_big'];
    if (json['category_items'] != null) {
      categoryItems = <CategoryItems>[];
      json['category_items'].forEach((v) {
        categoryItems!.add(CategoryItems.fromJson(v));
      });
    }
  }
}

class CategoryItems {
  String? subCategory;
  String? subCategoryImage;
  String? isItemsNumeric;
  String? symbolColor;
  List<SubCategoryItems>? subCategoryItems;

  CategoryItems(
      {this.subCategory,
      this.subCategoryImage,
      this.isItemsNumeric,
      this.symbolColor,
      this.subCategoryItems});

  CategoryItems.fromJson(Map<String, dynamic> json) {
    subCategory = json['sub_category'];
    subCategoryImage = json['sub_category_image'];
    isItemsNumeric = json['is_items_numeric'];
    symbolColor = json['symbol_color'];
    if (json['sub_category_items'] != null) {
      subCategoryItems = <SubCategoryItems>[];
      json['sub_category_items'].forEach((v) {
        subCategoryItems!.add(SubCategoryItems.fromJson(v));
      });
    }
  }
}

class SubCategoryItems {
  String? name;
  String? contentPath;

  SubCategoryItems({this.name, this.contentPath});

  SubCategoryItems.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    contentPath = json['content_Path'];
  }
}
