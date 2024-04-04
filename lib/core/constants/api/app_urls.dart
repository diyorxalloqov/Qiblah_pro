import 'package:qiblah_pro/core/constants/api/server.dart';

class AppUrls {
  static const names = '${Server.server}/api/v1/names/list';
  static const quronSurahList = '${Server.server}/api/v1/quran/list?';
  static const zikrNames = '${Server.server}/api/v1/categories/list';
  static const zikrs = '${Server.server}/api/v1/zikr/list';
  static const oyatById = '${Server.server}/api/v1/verses/list';
  static const oyatByJuz = '${Server.server}/api/v1/verses/juz';
  static const register = '${Server.server}/api/v1/user/register';
  static const temporaryRegister =
      '${Server.server}/api/v1/user/register/temporaryuser';
  static const login = '${Server.server}/api/v1//user/login/phone';
  static const putImage = '${Server.server}/api/v1/user/edit/avatar';
  static const changeContact = '${Server.server}/api/v1/user/edit/contact';
  static const changeName = '${Server.server}/api/v1/user/edit/name';
  static const changeLocation = '${Server.server}/api/v1/user/edit/location';
  static const changePremium = '${Server.server}/api/v1/user/edit/premium';
  static const changeLang = '${Server.server}/api/v1/user/edit/applang';
  static const deleteAccaunt = '${Server.server}/api/v1/user/delete';
}
