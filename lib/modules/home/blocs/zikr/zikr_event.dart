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

class ZikrGetFromApiEvent extends ZikrEvent {
  final int page;
  final int limit;
  final String categoryId;
  const ZikrGetFromApiEvent(
      {required this.page, required this.limit, required this.categoryId});
  @override
  // TODO: implement props
  List<Object> get props => [page, limit, categoryId];
}

class ZikrGetFromDBEvent extends ZikrEvent {
  final String categoryId;
  const ZikrGetFromDBEvent({required this.categoryId});

  @override
  // TODO: implement props
  List<Object> get props => [categoryId];
}


class SavedZikrEvent extends ZikrEvent {
  final String zikrId;
  final bool isSaved;
  const SavedZikrEvent({required this.zikrId, required this.isSaved});
  @override
  // TODO: implement props
  List<Object> get props => [zikrId, isSaved];
}

class GetSavedZikrsEvent extends ZikrEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
