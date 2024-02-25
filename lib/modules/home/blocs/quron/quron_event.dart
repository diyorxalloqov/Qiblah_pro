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
  const GetOyatFromDB({required this.index});
  @override
  // TODO: implement props
  List<Object> get props => [index];
}

class GetOyatFromApi extends QuronEvent {
  final int index;
  const GetOyatFromApi({required this.index});
  @override
  // TODO: implement props
  List<Object> get props => [index];
}

class ShowingTextEvent extends QuronEvent {
  final QuronShowingTextEnum text;
  const ShowingTextEvent({required this.text});
  @override
  // TODO: implement props
  List<Object> get props => [text];
}

class SavedAndReadedItemEvent extends QuronEvent {
  final bool isSaved;
  final bool isReaded;
  const SavedAndReadedItemEvent(
      {required this.isSaved, required this.isReaded});
  @override
  // TODO: implement props
  List<Object> get props => [isSaved, isReaded];
}
