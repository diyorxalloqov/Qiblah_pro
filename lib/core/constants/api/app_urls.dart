import 'package:qiblah_pro/core/constants/api/server.dart';

class AppUrls {
  static const names = '${Server.server}/api/v1/names/list';
  static const quronSurahList = '${Server.server}/api/v1/quran/list?';
  static const zikrNames = '${Server.server}/api/v1/categories/list';
  static const oyatById = '${Server.server}/api/v1/verses/list';
  static const register = '${Server.server}/api/v1/user/register';
  static const temporaryRegister =
      '${Server.server}/api/v1/user/register/temporaryuser';
}
