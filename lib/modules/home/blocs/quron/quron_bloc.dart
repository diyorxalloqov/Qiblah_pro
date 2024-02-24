import 'dart:async';

import 'package:dartz/dartz.dart';
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
    on<GetOyatFromApi>(_getOyatsApi);
    on<ShowingTextEvent>(_showingText);
    on<IsSavedItemEvent>(_isSavedItem);
    on<IsReadedItemEvent>(_isReadedItem);
    on<GetSavedAndReadedItem>(_savedReadedItems);
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

  FutureOr<void> _getOyatDb(
      GetOyatFromDB event, Emitter<QuronState> emit) async {
    emit(state.copyWith(status1: ActionStatus.isLoading));

    List<OyatModel>? dataFromDb =
        await _quronDBService.getOyatById(event.index);

    if (dataFromDb != null && dataFromDb.isNotEmpty) {
      emit(state.copyWith(
          oyatModel: dataFromDb, status1: ActionStatus.isSuccess));
    } else if (dataFromDb == null || dataFromDb.isEmpty) {
      add(GetOyatFromApi(index: event.index));
    } else {
      add(GetOyatFromApi(index: event.index));
    }
  }

  FutureOr<void> _getOyatsApi(
      GetOyatFromApi event, Emitter<QuronState> emit) async {
    emit(state.copyWith(status1: ActionStatus.isLoading));

    Either<String, List<OyatModel>> res =
        await _quronService.getOyatbyIndex(event.index);

    res.fold(
        (l) => emit(state.copyWith(status1: ActionStatus.isError, error: l)),
        (r) => emit(
            state.copyWith(status1: ActionStatus.isSuccess, oyatModel: r)));
  }

  FutureOr<void> _showingText(
      ShowingTextEvent event, Emitter<QuronState> emit) {
    if (event.text == QuronShowingTextEnum.arabic) {
      emit(state.copyWith(textEnum: QuronShowingTextEnum.arabic));
    } else if (event.text == QuronShowingTextEnum.meaning) {
      emit(state.copyWith(textEnum: QuronShowingTextEnum.meaning));
    } else if (event.text == QuronShowingTextEnum.reading) {
      emit(state.copyWith(textEnum: QuronShowingTextEnum.reading));
    }
  }

  Future<FutureOr<void>> _isSavedItem(
      IsSavedItemEvent event, Emitter<QuronState> emit) async {
    try {
      await _quronDBService.insertReadedSaved(isSaved: event.isSaved);
    } on DatabaseException catch (e) {
      print(e.result);
      print('databse exeption in bloc');
    }
  }

  FutureOr<void> _isReadedItem(
      IsReadedItemEvent event, Emitter<QuronState> emit) async {
    try {
      await _quronDBService.insertReadedSaved(isReaded: event.isReaded);
    } on DatabaseException catch (e) {
      print(e.result);
      print('databse exeption in bloc');
    }
  }

  Future<FutureOr<void>> _savedReadedItems(
      GetSavedAndReadedItem event, Emitter<QuronState> emit) async {
    try {
      List<OyatModel>? data =
          await _quronDBService.getReadedSavedById(event.oyatNumber);
      emit(state.copyWith(oyatModelSavedReaded: data));
    } on DatabaseException catch (e) {
      print(e.result);
      print('databse exeption in bloc');
    }
  }
}
