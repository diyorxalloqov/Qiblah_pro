class UserModel {
  final int? id;
  final String? name;
  final String? userLanguage;

  UserModel({this.id, this.name, this.userLanguage});

  Map<String, dynamic> toJson() {
    return {'id': id ?? 0, 'name': name ?? '', 'userLanguage': userLanguage ?? 'uz'};
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      userLanguage: json['userLanguage'] ?? 'uz',
    );
  }
}
