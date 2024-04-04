import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:qiblah_pro/core/constants/juz_numbers.dart';
import 'package:qiblah_pro/core/db/quron_db_service.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/models/oyat_model.dart';
import 'package:qiblah_pro/modules/home/models/quron_model.dart';

part 'quron_event.dart';
part 'quron_state.dart';

class QuronBloc extends Bloc<QuronEvent, QuronState> {
  QuronBloc() : super(const QuronState()) {
    // sura
    on<SurahGetFromApi>(_getSurahFromApi);
    on<QuronSurahGetEvent>(_getSurah);
    on<SizeChangerEvent>(_changeSize);
    on<ShowingTextEvent>(_showingText);
    // oyat
    on<GetOyatFromDB>(_getOyatDb);
    on<GetOyatFromApi>(_getOyatsApi);
    on<SavedItemEvent>(_savedItem);
    on<ReadedItemEvent>(_readedItem);
    on<GetJuzFromApi>(_getJuzApi);
    on<GetJuzFromDb>(_getjuzDB);
    on<GetSavedOyats>(_getSavedOyats);
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

  Future<FutureOr<void>> _getSurah(
      QuronSurahGetEvent event, Emitter<QuronState> emit) async {
    List<QuronModel>? dataFromDb = await _quronDBService.getQuron();
    emit(state.copyWith(status: ActionStatus.isLoading));

    try {
      if (dataFromDb != null && dataFromDb.isNotEmpty) {
        emit(state.copyWith(
            status: ActionStatus.isSuccess, quronModel: dataFromDb));
      } else {
        add(const SurahGetFromApi(pageItem: 1, limit: 114));
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

    if (dataFromDb != null) {
      // Check if any element in dataFromDb has the suraId equal to event.index
      // bool containsIndex =
      //     dataFromDb.any((element) => element.suraId == event.index);

      // if (containsIndex) {
      //   print("Data found in the database");
      //   emit(state.copyWith(
      //       oyatModel: dataFromDb, status1: ActionStatus.isSuccess));
      // } else {
      //   print("Data not found in the database. Fetching from API...");
      //   add(GetOyatFromApi(index: event.index));
      // }
       List<OyatModel> filteredData =
          dataFromDb.where((element) => element.suraId == event.index).toList();
          print("${filteredData.length} JUZ NUMBER BLOC");
          print("${dataFromDb.length} JUZ NUMBER BLOC");
      if (filteredData.isNotEmpty &&
          filteredData.length == event.suraLength) {
        // Check if the length of filtered data matches the expected length based on Juz numbers
        print("Data found in the database");
        emit(state.copyWith(
            oyatModel: filteredData, status1: ActionStatus.isSuccess));
      } else {
        print(
            "Filtered data not found in the database or length doesn't match. Fetching from API...");
        add(GetOyatFromApi(index: event.index));
      }
    } else {
      print('No data found in the database. Fetching from API...');
      add(GetOyatFromApi(index: event.index));
    }
  }

  FutureOr<void> _getOyatsApi(
      GetOyatFromApi event, Emitter<QuronState> emit) async {
    emit(state.copyWith(status1: ActionStatus.isLoading));
    Either<String, List<OyatModel>> res =
        await _quronService.getOyatbyIndex(event.index);
    res.fold(
        (l) => emit(state.copyWith(status1: ActionStatus.isError, error1: l)),
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

  Future<FutureOr<void>> _savedItem(
      SavedItemEvent event, Emitter<QuronState> emit) async {
    try {
      await _quronDBService.updateSaved(event.verseNumber, event.isSaved);
      print(event.verseNumber);
      print("${event.isSaved} SSSSSSSSSSSSSSSSSSSSSSSAVED BLOC");
    } on DatabaseException catch (e) {
      print(e.result);
      print('databse exeption in bloc');
    }
  }

  Future<FutureOr<void>> _readedItem(
      ReadedItemEvent event, Emitter<QuronState> emit) async {
    try {
      await _quronDBService.updateReaded(event.verseNumber, event.isReaded);
      print(event.verseNumber);
      print("${event.isReaded} RRRRRRRRRRRRRRRRRRREADED BLOC");
    } on DatabaseException catch (e) {
      print(e.result);
      print('databse exeption in bloc');
    }
  }

  ////// JUZLAR

  Future<FutureOr<void>> _getJuzApi(
      GetJuzFromApi event, Emitter<QuronState> emit) async {
    emit(state.copyWith(juzStatus: ActionStatus.isLoading));
    Either<String, List<OyatModel>> res =
        await _quronService.getOyatbyjuzNumber(event.index);
    res.fold(
        (l) =>
            emit(state.copyWith(juzStatus: ActionStatus.isError, errorJuz: l)),
        (r) => emit(state.copyWith(
            juzStatus: ActionStatus.isSuccess, oyatModelByJuz: r)));
  }

  Future<FutureOr<void>> _getjuzDB(
      GetJuzFromDb event, Emitter<QuronState> emit) async {
    emit(state.copyWith(juzStatus: ActionStatus.isLoading));

    List<OyatModel>? dataFromDb =
        await _quronDBService.getOyatJuzById(event.index);

    if (dataFromDb != null) {
      // Filter the list to get only items where juzNumber matches event.index
      List<OyatModel> filteredData =
          dataFromDb.where((oyat) => oyat.juzNumber == event.index).toList();
          print("${filteredData.length} JUZ NUMBER BLOC");
          print("${dataFromDb.length} JUZ NUMBER BLOC");
      if (filteredData.isNotEmpty &&
          filteredData.length == juzNumbers[event.index - 1]) {
        // Check if the length of filtered data matches the expected length based on Juz numbers
        print(filteredData.first.id);
        print("Data found in the database");
        emit(state.copyWith(
            oyatModelByJuz: filteredData, juzStatus: ActionStatus.isSuccess));
      } else {
        // Data length doesn't match, fetch from API
        print(
            "Filtered data not found in the database or length doesn't match. Fetching from API...");
        add(GetJuzFromApi(index: event.index));
      }
    } else {
      // Data not found in the database, fetch from API
      print('No data found in the database. Fetching from API...');
      add(GetJuzFromApi(index: event.index));
    }
  }

  Future<FutureOr<void>> _getSavedOyats(
      GetSavedOyats event, Emitter<QuronState> emit) async {
    emit(state.copyWith(savedOyatStatus: ActionStatus.isLoading));
    try {
      List<OyatModel>? dataFromDb = await _quronDBService.getSavedOyats();

      emit(state.copyWith(
          savedOyatStatus: ActionStatus.isSuccess, getSavedOyats: dataFromDb));
    } on DatabaseException catch (e) {
      emit(state.copyWith(
          savedOyatStatus: ActionStatus.isError,
          savedOyatError: e.result.toString()));
    }
  }
}
