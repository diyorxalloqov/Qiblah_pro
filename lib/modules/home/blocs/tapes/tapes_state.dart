part of 'tapes_bloc.dart';

class TapesState extends Equatable {
  final TapesModel? tapesModel;
  final ActionStatus status;
  final String error;

  const TapesState(
      {this.tapesModel, this.error = '', this.status = ActionStatus.isInitial});

  TapesState copyWith(
      {TapesModel? tapesModel, ActionStatus? status, String? error}) {
    return TapesState(
      tapesModel: tapesModel ?? tapesModel,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [tapesModel, status, error];
}
