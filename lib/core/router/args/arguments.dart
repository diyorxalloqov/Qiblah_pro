// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class OtpPageArguments {
  final String phone;
  OtpPageArguments({required this.phone});
}

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
  final String suradata;
  JuzlarDetailsArgument({
    required this.suraName,
    required this.index,
    required this.suradata,
  });
}

class NamesDetailsArgument {
  final NamesBloc namesBloc;
  final int index;
  NamesDetailsArgument(
      {required this.namesBloc,
      required this.index});
}
