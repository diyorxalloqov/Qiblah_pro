import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/models/zikr_model.dart';
import 'package:qiblah_pro/modules/home/service/zikr_service.dart';
import 'package:vibration/vibration.dart';

part 'zikr_event.dart';
part 'zikr_state.dart';

class ZikrBloc extends Bloc<ZikrEvent, ZikrState> {
  ZikrBloc() : super(const ZikrState()) {
    on<ZikrVibrationEvent>(_vibration);
    on<IncrementZikr>(_incrementZikr);
    on<RefreshZikrEvent>(refreshZikr);
    on<ZikrCategoryGetFromApiEvent>(_getCategoriesApi);
    on<ZikrCategoryGetDBEvent>(_getCategoryDB);
  }
  final ZikrService _zikrService = ZikrService();
  final ZikrDBSevice _zikrDBSevice = ZikrDBSevice();

  int currentZikr = 0;
  int currentZikrOuterCount = 0;
  static const tasbehSizes = [11, 33, 99];

  FutureOr<void> _vibration(
      ZikrVibrationEvent event, Emitter<ZikrState> emit) async {
    bool? hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator == null || !hasVibrator) {
      return;
    }
    if (event.isVibration) {
      var hasCustomVibrationControl =
          await Vibration.hasCustomVibrationsSupport();
      if (hasCustomVibrationControl != null && hasCustomVibrationControl) {
        int duration = 80;
        int amplitude = 128;
        Vibration.vibrate(duration: duration, amplitude: amplitude);
      }
      emit(state.copyWith(isVibration: true));
    } else {
      emit(state.copyWith(isVibration: false));
    }
  }

  FutureOr<void> _incrementZikr(IncrementZikr event, Emitter<ZikrState> emit) {
    currentZikr++;
    if (currentZikr == tasbehSizes[event.index] + 1) {
      currentZikr = 1;
      currentZikrOuterCount++;
      if (state.isVibration) {
        Vibration.vibrate(duration: 400, amplitude: 200);
      }
    } else {
      add(ZikrVibrationEvent(isVibration: state.isVibration));
    }
  }

  FutureOr<void> refreshZikr(RefreshZikrEvent event, Emitter<ZikrState> emit) {
    currentZikr = 1;
    currentZikrOuterCount = 0;
  }

  Future<FutureOr<void>> _getCategoriesApi(
      ZikrCategoryGetFromApiEvent event, Emitter<ZikrState> emit) async {
    Either<String, List<ZikrModel>> res = await _zikrService.getCategories();
    res.fold(
        (l) => emit(state.copyWith(error: l, status: ActionStatus.isError)),
        (r) =>
            emit(state.copyWith(zikrModel: r, status: ActionStatus.isSuccess)));
  }

  Future<FutureOr<void>> _getCategoryDB(
      ZikrCategoryGetDBEvent event, Emitter<ZikrState> emit) async {
    List<ZikrModel>? data = await _zikrDBSevice.getZikrs();
    try {
      if (data!.isNotEmpty) {
        emit(state.copyWith(zikrModel: data, status: ActionStatus.isSuccess));
      } else {
        emit(state.copyWith(
            error: 'Database is Empty zikrs', status: ActionStatus.isError));
        add(ZikrCategoryGetFromApiEvent());
      }
    } on DatabaseException catch (e) {
      emit(state.copyWith(error: e.toString(), status: ActionStatus.isError));
    }
  }
}
