part of 'quron_bloc.dart';

class QuronState extends Equatable {
  final ActionStatus status;
  final ActionStatus status1;
  final String error1;
  final String error;
  final List<QuronModel> quronModel;
  final double? quronSize;
  final List<OyatModel> oyatModel;
  final List<OyatModel> oyatModelByJuz;
  final List<OyatModel> getSavedOyats;
  final ActionStatus savedOyatStatus;
  final String savedOyatError;
  final ActionStatus juzStatus;
  final String errorJuz;
  final double? textSize;
  final bool isShowingArabic;
  final bool isShowingMeaning;
  final bool isShowingReading;

  const QuronState(
      {this.error = '',
      this.error1 = '',
      this.status1 = ActionStatus.isInitial,
      this.quronModel = const [],
      this.getSavedOyats = const [],
      this.savedOyatStatus = ActionStatus.isInitial,
      this.savedOyatError = '',
      this.isShowingArabic = true,
      this.isShowingMeaning = true,
      this.isShowingReading = true,
      this.quronSize,
      this.oyatModelByJuz = const [],
      this.juzStatus = ActionStatus.isInitial,
      this.errorJuz = '',
      this.oyatModel = const [],
      this.textSize,
      this.status = ActionStatus.isInitial});

  QuronState copyWith(
      {ActionStatus? status,
      String? error,
      String? error1,
      List<OyatModel>? oyatModelByJuz,
      ActionStatus? juzStatus,
      String? errorJuz,
      double? quronSize,
      ActionStatus? status1,
      List<OyatModel>? getSavedOyats,
      double? textSize,
      ActionStatus? savedOyatStatus,
      String? savedOyatError,
      List<OyatModel>? oyatModel,
      bool? isShowingArabic,
      bool? isShowingMeaning,
      bool? isShowingReading,
      List<QuronModel>? quronModel}) {
    return QuronState(
        error: error ?? this.error,
        error1: error1 ?? this.error1,
        status1: status1 ?? this.status1,
        quronSize: quronSize ?? this.quronSize,
        textSize: textSize ?? this.textSize,
        oyatModel: oyatModel ?? this.oyatModel,
        status: status ?? this.status,
        quronModel: quronModel ?? this.quronModel,
        errorJuz: errorJuz ?? this.errorJuz,
        juzStatus: juzStatus ?? this.juzStatus,
        getSavedOyats: getSavedOyats ?? this.getSavedOyats,
        savedOyatStatus: savedOyatStatus ?? this.savedOyatStatus,
        savedOyatError: savedOyatError ?? this.savedOyatError,
        isShowingArabic: isShowingArabic ?? this.isShowingArabic,
        isShowingMeaning: isShowingMeaning ?? this.isShowingMeaning,
        isShowingReading: isShowingReading ?? this.isShowingReading,
        oyatModelByJuz: oyatModelByJuz ?? this.oyatModelByJuz);
  }

  @override
  List<Object?> get props => [
        status,
        error,
        error1,
        quronModel,
        oyatModel,
        quronSize,
        textSize,
        status1,
        errorJuz,
        juzStatus,
        oyatModelByJuz,
        getSavedOyats,
        savedOyatStatus,
        savedOyatError,
        isShowingArabic,
        isShowingMeaning,
        isShowingReading
      ];
}
