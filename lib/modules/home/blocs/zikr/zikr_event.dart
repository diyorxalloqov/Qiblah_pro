// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'zikr_bloc.dart';

abstract class ZikrEvent extends Equatable {
  const ZikrEvent();

  @override
  List<Object> get props => [];
}

class IncrementZikr extends ZikrEvent {
  final int index;
  const IncrementZikr({required this.index});
  @override
  // TODO: implement props
  List<Object> get props => [index];
}

class ZikrVibrationEvent extends ZikrEvent {
  final bool isVibration;
  const ZikrVibrationEvent({required this.isVibration});
  @override
  // TODO: implement props
  List<Object> get props => [isVibration];
}

class RefreshZikrEvent extends ZikrEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ZikrCategoryGetFromApiEvent extends ZikrEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ZikrCategoryGetDBEvent extends ZikrEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
