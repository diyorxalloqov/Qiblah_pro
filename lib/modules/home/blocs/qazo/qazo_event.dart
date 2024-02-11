// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'qazo_bloc.dart';

abstract class QazoEvent extends Equatable {
  const QazoEvent();

  @override
  List<Object> get props => [];
}

class BomdodEvent extends QazoEvent {
  final bool isIncrement;
  const BomdodEvent({required this.isIncrement});

  @override
  // TODO: implement props
  List<Object> get props => [isIncrement];
}

class PeshinEvent extends QazoEvent {
  final bool isIncrement;
  const PeshinEvent({required this.isIncrement});

  @override
  // TODO: implement props
  List<Object> get props => [isIncrement];
}

class AsrEvent extends QazoEvent {
  final bool isIncrement;
  const AsrEvent({required this.isIncrement});

  @override
  // TODO: implement props
  List<Object> get props => [isIncrement];
}

class ShomEvent extends QazoEvent {
  final bool isIncrement;
  const ShomEvent({required this.isIncrement});

  @override
  // TODO: implement props
  List<Object> get props => [isIncrement];
}

class XuftonEvent extends QazoEvent {
  final bool isIncrement;
  const XuftonEvent({required this.isIncrement});

  @override
  // TODO: implement props
  List<Object> get props => [isIncrement];
}

class GetOverallQazo extends QazoEvent {
  const GetOverallQazo();
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class GetOverallQazoCount extends QazoEvent {
  const GetOverallQazoCount();
  @override
  // TODO: implement props
  List<Object> get props => [];
}