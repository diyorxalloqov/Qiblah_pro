// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'names_bloc.dart';

abstract class NamesEvent extends Equatable {
  const NamesEvent();

  @override
  List<Object> get props => [];
}

class GetNamesEvent extends NamesEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class PlayNameEvent extends NamesEvent {
  final bool isPlaying;
  final String url;
  const PlayNameEvent({required this.isPlaying, required this.url});
  @override
  // TODO: implement props
  List<Object> get props => [isPlaying, url];
}
