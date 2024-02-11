part of 'zikr_bloc.dart';

class ZikrState extends Equatable {
  const ZikrState();

  ZikrState copyWith(
      {NamesModel? namesModel,
      ActionStatus? status,
      String? error,
      bool? isPlaying,
      List? audiosList}) {
    return ZikrState();
  }

  @override
  List<Object?> get props => [];
}
