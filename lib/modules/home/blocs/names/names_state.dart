part of 'names_bloc.dart';

class NamesState extends Equatable {
  final List<NamesData> namesModel;
  final ActionStatus status;
  final String error;

  const NamesState(
      {this.namesModel = const [],
      this.error = '',
      this.status = ActionStatus.isInitial});

  NamesState copyWith(
      {List<NamesData>? namesModel,
      ActionStatus? status,
      String? error,
      bool? isPlaying,
      List? audiosList}) {
    return NamesState(
      namesModel: namesModel ?? this.namesModel,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [namesModel, status, error];
}
