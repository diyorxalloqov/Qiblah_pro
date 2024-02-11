class UserModel {
  final int id;
  final String name;
  final String userLanguage;
  final bool isMan;

  UserModel(
      {this.id = 0,
      this.name = '',
      this.isMan = false,
      this.userLanguage = 'uz'});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'userLanguage': userLanguage,
      'isMan': isMan ? 1 : 0
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      userLanguage: json['userLanguage'] ?? 'uz',
      isMan: json['isMan'] == 0 ? true : false,
    );
  }
}
