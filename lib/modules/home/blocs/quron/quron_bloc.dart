import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:qiblah_pro/core/db/quron_db_service.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/models/oyat_model.dart';
import 'package:qiblah_pro/modules/home/models/quron_model.dart';

part 'quron_event.dart';
part 'quron_state.dart';

class QuronBloc extends Bloc<QuronEvent, QuronState> {
  QuronBloc() : super(const QuronState()) {
    on<SurahGetFromApi>(_getSurahFromApi);
    on<QuronSurahGetEvent>(getSurah);
    add(QuronSurahGetEvent());
    on<SizeChangerEvent>(_changeSize);
    on<GetOyatFromDB>(_getOyatDb);
  }
  final QuronService _quronService = QuronService();
  final QuronDBService _quronDBService = QuronDBService();

  Future<FutureOr<void>> _getSurahFromApi(
      SurahGetFromApi event, Emitter<QuronState> emit) async {
    emit(state.copyWith(status: ActionStatus.isLoading));
    Either<String, List<QuronModel>> response =
        await _quronService.getQuranList(event.limit, event.pageItem);
    response.fold(
        (l) => emit(state.copyWith(status: ActionStatus.isError, error: l)),
        (r) => emit(
            state.copyWith(status: ActionStatus.isSuccess, quronModel: r)));
  }

  Future<FutureOr<void>> getSurah(
      QuronSurahGetEvent event, Emitter<QuronState> emit) async {
    List<QuronModel>? dataFromDb = await _quronDBService.getQuron();

    try {
      if (dataFromDb != null && dataFromDb.isNotEmpty) {
        emit(state.copyWith(
            status: ActionStatus.isSuccess, quronModel: dataFromDb));
      } else {
        add(const SurahGetFromApi(pageItem: 1, limit: 114));
        emit(state.copyWith(
            status: ActionStatus.isError, error: 'Database is empty'));
      }
    } on DatabaseException catch (e) {
      emit(state.copyWith(error: e.toString(), status: ActionStatus.isError));
    }
  }

  FutureOr<void> _changeSize(SizeChangerEvent event, Emitter<QuronState> emit) {
    emit(state.copyWith(quronSize: event.quronSize, textSize: event.textSize));
  }

  // FutureOr<void> _getOyatDb(
  //     GetOyatFromDB event, Emitter<QuronState> emit) async {
  //   // List<OyatModel>? dataFromDb =
  //   //     await _quronDBService.getOyatById(event.index);
  //   Either<String, List<OyatModel>> res =
  //       await _quronService.getOyatbyIndex(event.index);
  //   print("${state.oyatModel[event.index].suraId.toString()} oyat suraId");

  //   if (/* event.index - 1 == dataFromDb[event.index-1].suraId */ 1 != 1) {
  //     print('SALOM TRUE');
  //     try {
  //       print('oyat db isnot empty');
  //       // emit(state.copyWith(oyatModel: dataFromDb));
  //     } on DatabaseException catch (e) {
  //       emit(state.copyWith(status: ActionStatus.isError, error: e.toString()));
  //     }
  //   } else {
  //     print('oyat db is empty');
  //     res.fold(
  //         (l) => emit(state.copyWith(status: ActionStatus.isError, error: l)),
  //         (r) => emit(
  //             state.copyWith(status: ActionStatus.isSuccess, oyatModel: r)));
  //   }
  // }

  FutureOr<void> _getOyatDb(
      GetOyatFromDB event, Emitter<QuronState> emit) async {
    try {
      File file = await DefaultCacheManager().getSingleFile(
          "https://qibla.onrender.com/api/v1/verses/list/${event.index}?lang=uzbek");
          print("$file FILLLLLLLLLLLLLLLLLLLLLLLLLLELELELELELELE");
      if (file.path.isEmpty) {
        emit(state.copyWith(
            error: 'Iltimos internetingizni tekshiring',
            status1: ActionStatus.isError));
      }

print('${file.absolute} ');
      if (file.existsSync()) {
        String cachedData = await file.readAsString();

        Map<String, dynamic> decodedData = json.decode(cachedData);

        if (decodedData.containsKey("data") && decodedData["data"] is List) {
          List<OyatModel> dataList = (decodedData["data"] as List)
              .map((e) => OyatModel.fromJson(e))
              .toList();

          emit(state.copyWith(
              status1: ActionStatus.isSuccess, oyatModel: dataList));
        } else {
          emit(state.copyWith(
              status1: ActionStatus.isError,
              error: "Data is not in the expected format"));
        }
      } else {
        Either<String, List<OyatModel>> res =
            await _quronService.getOyatbyIndex(event.index);

        res.fold(
          (l) => emit(state.copyWith(status1: ActionStatus.isError, error: l)),
          (r) => emit(
              state.copyWith(status1: ActionStatus.isSuccess, oyatModel: r)),
        );
      }
    } catch (e) {
      emit(state.copyWith(status1: ActionStatus.isError, error: e.toString()));
    }
  }
}
