// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'quron_bloc.dart';

abstract class QuronEvent extends Equatable {
  const QuronEvent();

  @override
  List<Object> get props => [];
}

class SurahGetFromApi extends QuronEvent {
  final int pageItem;
  final int limit;

  const SurahGetFromApi({required this.pageItem, required this.limit});
  @override
  // TODO: implement props
  List<Object> get props => [pageItem, limit];
}

class QuronSurahGetEvent extends QuronEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SizeChangerEvent extends QuronEvent {
  final double? quronSize;
  final double? textSize;
  const SizeChangerEvent({this.quronSize, this.textSize});

  @override
  // TODO: implement props
  List<Object> get props => [quronSize!, textSize!];
}

class GetOyatFromDB extends QuronEvent {
  final int index;
  final int suraLength;
  const GetOyatFromDB({required this.index, required this.suraLength});
  @override
  // TODO: implement props
  List<Object> get props => [index, suraLength];
}

class GetOyatFromApi extends QuronEvent {
  final int index;
  const GetOyatFromApi({required this.index});
  @override
  // TODO: implement props
  List<Object> get props => [index];
}

class ShowingTextEvent extends QuronEvent {
  final int index;
  final bool isShowing;
  const ShowingTextEvent({required this.index, required this.isShowing});
  @override
  // TODO: implement props
  List<Object> get props => [index, isShowing];
}

class SavedItemEvent extends QuronEvent {
  final bool isSaved;
  final int verseNumber;

  const SavedItemEvent({required this.isSaved, required this.verseNumber});
  @override
  // TODO: implement props
  List<Object> get props => [isSaved, verseNumber];
}

class ReadedItemEvent extends QuronEvent {
  final bool isReaded;
  final int verseNumber;

  const ReadedItemEvent({required this.isReaded, required this.verseNumber});
  @override
  // TODO: implement props
  List<Object> get props => [isReaded, verseNumber];
}

class GetJuzFromApi extends QuronEvent {
  final int index;
  const GetJuzFromApi({required this.index});
  @override
  // TODO: implement props
  List<Object> get props => [index];
}

class GetJuzFromDb extends QuronEvent {
  final int index;
  const GetJuzFromDb({required this.index});
  @override
  // TODO: implement props
  List<Object> get props => [index];
}

class GetSavedOyats extends QuronEvent {
  const GetSavedOyats();
  @override
  // TODO: implement props
  List<Object> get props => [];
}
