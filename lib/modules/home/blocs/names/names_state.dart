part of 'names_bloc.dart';

class NamesState extends Equatable {
  final NamesModel? namesModel;
  final ActionStatus status;
  final String error;
  final List audiosList;
  final bool isPlaying ;

  const NamesState(
      {this.namesModel,
      this.audiosList = const [],
      this.error = '',
      this.isPlaying = false,
      this.status = ActionStatus.isInitial});

  NamesState copyWith(
      {NamesModel? namesModel,
      ActionStatus? status,
      String? error,
      bool? isPlaying,
      List? audiosList}) {
    return NamesState(
        namesModel: namesModel ?? this.namesModel,
        error: error ?? this.error,
        status: status ?? this.status,
        isPlaying: isPlaying ?? this.isPlaying,
        audiosList: audiosList ?? this.audiosList);
  }

  @override
  List<Object?> get props => [namesModel, status, error, audiosList, isPlaying];
}
