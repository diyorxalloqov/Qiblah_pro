// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class SuralarDetailsPageArguments {
  final String suraName;
  final int suraVerseCount;
  final int suraId;
  SuralarDetailsPageArguments(
      {required this.suraName,
      required this.suraVerseCount,
      required this.suraId});
}

class JuzlarDetailsArgument {
  final String suraName;
  final int index;
  JuzlarDetailsArgument({required this.suraName, required this.index});
}

class NamesDetailsArgument {
  final NamesBloc namesBloc;
  final int index;
  NamesDetailsArgument({required this.namesBloc, required this.index});
}

class ZikrArguments {
  final ZikrBloc zikrBloc;
  final String categoryId;
  final String categoryName;
  ZikrArguments(
      {required this.zikrBloc,
      required this.categoryName,
      required this.categoryId});
}

class ZikrDetailsArgument {
  final ZikrBloc zikrBloc;
  final int currentIndex;
  ZikrDetailsArgument({required this.zikrBloc, required this.currentIndex});
}
