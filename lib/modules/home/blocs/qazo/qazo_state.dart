part of 'qazo_bloc.dart';

class QazoState extends Equatable {
  final int bomdod;
  final int peshin;
  final int asr;
  final int shom;
  final int xufton;
  final int overall;
  final bool? isIncrement;

  const QazoState(
      {this.isIncrement,
      this.bomdod = 0,
      this.peshin = 0,
      this.asr = 0,
      this.shom = 0,
      this.xufton = 0,
      this.overall = 0});

  QazoState copyWith(
      {bool? isIncrement,
      int? peshin,
      int? bomdod,
      int? asr,
      int? xufton,
      int? shom,
      int? overall}) {
    return QazoState(
        isIncrement: isIncrement ?? this.isIncrement,
        bomdod: bomdod ?? this.bomdod,
        peshin: peshin ?? this.peshin,
        asr: asr ?? this.asr,
        shom: shom ?? this.shom,
        xufton: xufton ?? this.xufton,
        overall: overall ?? this.overall);
  }

  @override
  List<Object?> get props =>
      [isIncrement, bomdod, peshin, asr, shom, xufton, overall];
}
