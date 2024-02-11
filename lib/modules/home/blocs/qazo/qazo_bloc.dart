import 'dart:async';

import 'package:qiblah_pro/core/db/shared_preferences.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

part 'qazo_event.dart';
part 'qazo_state.dart';

class QazoBloc extends Bloc<QazoEvent, QazoState> {
  QazoBloc() : super(const QazoState()) {
    on<BomdodEvent>(_bomdodData);
    on<PeshinEvent>(_peshinData);
    on<AsrEvent>(_asrData);
    on<ShomEvent>(_shomData);
    on<XuftonEvent>(_xuftonData);
    on<GetOverallQazo>(_qazos);
    add(const GetOverallQazo());
    on<GetOverallQazoCount>(_count);
    add(const GetOverallQazoCount());
  }

  int? _bomdod = StorageRepository.getDouble(Keys.bomdod).toInt();
  int? _peshin = StorageRepository.getDouble(Keys.peshin).toInt();
  int? _asr = StorageRepository.getDouble(Keys.asr).toInt();
  int? _shom = StorageRepository.getDouble(Keys.shom).toInt();
  int? _xufton = StorageRepository.getDouble(Keys.xufton).toInt();

  int? get bomdod => _bomdod;
  int? get peshin => _peshin;
  int? get asr => _asr;
  int? get shom => _shom;
  int? get xufton => _xufton;

  FutureOr<void> _bomdodData(BomdodEvent event, Emitter<QazoState> emit) async {
    int currentCount = _bomdod ?? 0;
    if (event.isIncrement) {
      currentCount += 1;
    } else {
      if (currentCount > 0) {
        currentCount -= 1;
      }
    }
    _bomdod = currentCount;
    await StorageRepository.putDouble(Keys.bomdod, currentCount.toDouble());
    add(const GetOverallQazoCount());
    emit(state.copyWith(bomdod: currentCount));
  }

  FutureOr<void> _peshinData(PeshinEvent event, Emitter<QazoState> emit) async {
    int currentCount = _peshin ?? 0;
    if (event.isIncrement) {
      currentCount += 1;
    } else {
      if (currentCount > 0) {
        currentCount -= 1;
      }
    }
    _peshin = currentCount;
    await StorageRepository.putDouble(Keys.peshin, currentCount.toDouble());
    add(const GetOverallQazoCount());
    emit(state.copyWith(peshin: currentCount));
  }

  FutureOr<void> _asrData(AsrEvent event, Emitter<QazoState> emit) async {
    int currentCount = _asr ?? 0;
    if (event.isIncrement) {
      currentCount += 1;
    } else {
      if (currentCount > 0) {
        currentCount -= 1;
      }
    }
    _asr = currentCount;
    await StorageRepository.putDouble(Keys.asr, currentCount.toDouble());
    add(const GetOverallQazoCount());
    emit(state.copyWith(asr: currentCount));
  }

  FutureOr<void> _shomData(ShomEvent event, Emitter<QazoState> emit) async {
    int currentCount = _shom ?? 0;
    if (event.isIncrement) {
      currentCount += 1;
    } else {
      if (currentCount > 0) {
        currentCount -= 1;
      }
    }
    _shom = currentCount;
    add(const GetOverallQazoCount());
    await StorageRepository.putDouble(Keys.shom, currentCount.toDouble());
    emit(state.copyWith(shom: currentCount));
  }

  FutureOr<void> _xuftonData(XuftonEvent event, Emitter<QazoState> emit) async {
    int currentCount = _xufton ?? 0;
    if (event.isIncrement) {
      currentCount += 1;
    } else {
      if (currentCount > 0) {
        currentCount -= 1;
      }
    }
    _xufton = currentCount;
    add(const GetOverallQazoCount());
    await StorageRepository.putDouble(Keys.xufton, currentCount.toDouble());
    emit(state.copyWith(xufton: currentCount));
  }

  FutureOr<void> _qazos(GetOverallQazo event, Emitter<QazoState> emit) {
    emit(state.copyWith(
        bomdod: StorageRepository.getDouble(Keys.bomdod).toInt(),
        peshin: StorageRepository.getDouble(Keys.peshin).toInt(),
        asr: StorageRepository.getDouble(Keys.asr).toInt(),
        shom: StorageRepository.getDouble(Keys.shom).toInt(),
        xufton: StorageRepository.getDouble(Keys.xufton).toInt()));
  }

  FutureOr<void> _count(GetOverallQazoCount event, Emitter<QazoState> emit) {
    int overal = _bomdod! + _peshin! + _asr! + _shom! + _xufton!;
    emit(state.copyWith(overall: overal));
  }
}
