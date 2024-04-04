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
    on<ZikrGetFromApiEvent>(_zikrgetFromApi);
    on<ZikrGetFromDBEvent>(_zikrgetFromDb);
    on<SavedZikrEvent>(_savedZikr);
    on<GetSavedZikrsEvent>(_savedZikrs);
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
    Either<String, List<ZikrCategoryModel>> res =
        await _zikrService.getCategories();
    res.fold(
        (l) => emit(state.copyWith(error: l, status: ActionStatus.isError)),
        (r) => emit(state.copyWith(
            zikrCategroyModel: r, status: ActionStatus.isSuccess)));
  }

  Future<FutureOr<void>> _getCategoryDB(
      ZikrCategoryGetDBEvent event, Emitter<ZikrState> emit) async {
    List<ZikrCategoryModel>? data = await _zikrDBSevice.getCategory();
    try {
      if (data != null) {
        if (data.isNotEmpty) {
          emit(state.copyWith(
              zikrCategroyModel: data, status: ActionStatus.isSuccess));
        } else {
          emit(state.copyWith(
              error: 'Database is Empty zikrs', status: ActionStatus.isError));
          add(ZikrCategoryGetFromApiEvent());
        }
      }
    } on DatabaseException catch (e) {
      emit(state.copyWith(error: e.toString(), status: ActionStatus.isError));
    }
  }

  Future<FutureOr<void>> _zikrgetFromApi(
      ZikrGetFromApiEvent event, Emitter<ZikrState> emit) async {
    emit(state.copyWith(zikrStatus: ActionStatus.isLoading));
    Either<String, List<ZikrModel>> data = await _zikrService.getZikrs(
        int.parse(event.categoryId), event.limit, event.page);
    data.fold(
        (l) => emit(
            state.copyWith(zikrError: l, zikrStatus: ActionStatus.isError)),
        (r) => emit(
            state.copyWith(zikrModel: r, zikrStatus: ActionStatus.isSuccess)));
  }

  Future<FutureOr<void>> _zikrgetFromDb(
      ZikrGetFromDBEvent event, Emitter<ZikrState> emit) async {
    List<ZikrModel>? localdata = await _zikrDBSevice.getZikrs(event.categoryId);
    if (localdata != null && localdata.isNotEmpty) {
      // Check if any element in localdata has the suraId equal to event.index
      bool containsIndex =
          localdata.any((element) => element.categoryId == event.categoryId);

      if (containsIndex) {
        print("Data found in the database");
        emit(state.copyWith(
            zikrModel: localdata, zikrStatus: ActionStatus.isSuccess));
      } else {
        print("Data not found in the database. Fetching from API...");
        add(ZikrGetFromApiEvent(
            page: 1, limit: 100, categoryId: event.categoryId));
      }
    } else {
      print('No data found in the database. Fetching from API...');
      add(ZikrGetFromApiEvent(
          page: 1, limit: 100, categoryId: event.categoryId));
    }
  }

  Future<FutureOr<void>> _savedZikr(
      SavedZikrEvent event, Emitter<ZikrState> emit) async {
    await _zikrDBSevice.updateSaved(event.zikrId, event.isSaved);
  }

  Future<FutureOr<void>> _savedZikrs(
      GetSavedZikrsEvent event, Emitter<ZikrState> emit) async {
    emit(state.copyWith(savedZikrStatus: ActionStatus.isLoading));
    List<ZikrModel>? data = await _zikrDBSevice.getSavedZikrs();
    print("$data BLOC DATA");
    try {
      if (data != null) {
        print('HELLO');
        if (data.isNotEmpty) {
          print(true);
          emit(state.copyWith(
              savedZikrs: data, savedZikrStatus: ActionStatus.isSuccess));
        } else {
          emit(state.copyWith(savedZikrStatus: ActionStatus.isError));
        }
      }
    } on DatabaseException catch (e) {
      emit(state.copyWith(
          error: e.toString(), savedZikrStatus: ActionStatus.isError));
    }
  }
}
