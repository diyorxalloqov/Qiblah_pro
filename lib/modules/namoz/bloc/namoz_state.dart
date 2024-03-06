part of 'namoz_bloc.dart';

class NamozState extends Equatable {
  final ActionStatus status;
  final String error;
  final List<NamozModel> namozModel;

  const NamozState(
      {this.error = '',
      this.namozModel = const [],
      this.status = ActionStatus.isInitial});

  NamozState copyWith(
      {ActionStatus? status, List<NamozModel>? namozModel, String? error}) {
    return NamozState(
        namozModel: namozModel ?? this.namozModel,
        error: error ?? this.error,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status, namozModel, error];
}
