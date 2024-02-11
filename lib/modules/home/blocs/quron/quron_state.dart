part of 'quron_bloc.dart';

class QuronState extends Equatable {
  final ActionStatus status;
  final String error;
  final List audiosList;
  final bool isPlaying;

  const QuronState(
      {this.audiosList = const [],
      this.error = '',
      this.isPlaying = false,
      this.status = ActionStatus.isInitial});

  QuronState copyWith(
      {ActionStatus? status,
      String? error,
      bool? isPlaying,
      List? audiosList}) {
    return QuronState(
        error: error ?? this.error,
        status: status ?? this.status,
        isPlaying: isPlaying ?? this.isPlaying,
        audiosList: audiosList ?? this.audiosList);
  }

  @override
  List<Object?> get props => [status, error, audiosList, isPlaying];
}
