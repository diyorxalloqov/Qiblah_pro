part of 'quron_bloc.dart';

class QuronState extends Equatable {
  final ActionStatus status;
  final String error;
  final QuronModel? quronModel;

  const QuronState({
    this.error = '',
    this.quronModel,
    this.status = ActionStatus.isInitial,
  });

  QuronState copyWith(
      {ActionStatus? status,
      String? error,
      bool? isPlaying,
      List? audiosList}) {
    return QuronState(
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status, error];
}
