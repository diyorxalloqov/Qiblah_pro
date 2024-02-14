// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'quron_bloc.dart';

abstract class QuronEvent extends Equatable {
  const QuronEvent();

  @override
  List<Object> get props => [];
}

class QuronSurahGetEvent extends QuronEvent {
  final int pageItem;
  final int limit;
  final String lang;

  const QuronSurahGetEvent(
      {required this.pageItem, required this.lang, required this.limit});
  @override
  // TODO: implement props
  List<Object> get props => [pageItem, lang, limit];
}
