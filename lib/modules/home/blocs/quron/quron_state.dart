part of 'quron_bloc.dart';

class QuronState extends Equatable {
  final ActionStatus status;
  final ActionStatus status1;

  final String error;
  final List<QuronModel> quronModel;
  final double? quronSize;
  final List<OyatModel> oyatModel;
  final double? textSize;
  final QuronShowingTextEnum? textEnum;

  const QuronState(
      {this.error = '',
      this.status1 = ActionStatus.isInitial,
      this.quronModel = const [],
      this.textEnum,
      this.quronSize,
      this.oyatModel = const [],
      this.textSize,
      this.status = ActionStatus.isInitial});

  QuronState copyWith(
      {ActionStatus? status,
      String? error,
      double? quronSize,
      ActionStatus? status1,
      double? textSize,
      QuronShowingTextEnum? textEnum,
      List<OyatModel>? oyatModel,
      List<QuronModel>? quronModel}) {
    return QuronState(
        error: error ?? this.error,
        status1: status1 ?? this.status1,
        quronSize: quronSize ?? this.quronSize,
        textSize: textSize ?? this.textSize,
        oyatModel: oyatModel ?? this.oyatModel,
        status: status ?? this.status,
        textEnum: textEnum ?? this.textEnum,
        quronModel: quronModel ?? this.quronModel);
  }

  @override
  List<Object?> get props => [
        status,
        error,
        quronModel,
        oyatModel,
        quronSize,
        textSize,
        textEnum
      ];
}
