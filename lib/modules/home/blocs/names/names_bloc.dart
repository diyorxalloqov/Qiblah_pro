import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:qiblah_pro/core/db/names_db_service.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

part 'names_event.dart';
part 'names_state.dart';

class NamesBloc extends Bloc<NamesEvent, NamesState> {
  final NamesService _namesService = NamesService();
  final NamesDbService _namesDbService = NamesDbService();

  NamesBloc() : super(const NamesState()) {
    on<GetNamesFromApiEvent>(_getNamesFromApi);
    on<GetNamesEvent>(_getNames);
    add(GetNamesEvent());
  }

  // late PermissionStatus _audioPersmission;
  Future<void> _getNamesFromApi(
      GetNamesFromApiEvent event, Emitter<NamesState> emit) async {
    emit(state.copyWith(status: ActionStatus.isLoading));
    Either<String, List<NamesData>> res = await _namesService.getNames();

    res.fold(
      (error) =>
          emit(state.copyWith(status: ActionStatus.isError, error: error)),
      (data) => emit(
          state.copyWith(status: ActionStatus.isSuccess, namesModel: data)),
    );
  }

  FutureOr<void> _getNames(
      GetNamesEvent event, Emitter<NamesState> emit) async {
    try {
      // Retrieve all data from the database
      List<NamesData>? dataFromDb = await _namesDbService.getNames();

      if (dataFromDb != null && dataFromDb.isNotEmpty) {
        emit(state.copyWith(
            status: ActionStatus.isSuccess, namesModel: dataFromDb));
      } else {
        add(GetNamesFromApiEvent());
        emit(state.copyWith(
            status: ActionStatus.isError, error: 'Database is empty'));
      }
    } on DatabaseException catch (e) {
      emit(state.copyWith(status: ActionStatus.isError, error: e.toString()));
    }
  }
}
