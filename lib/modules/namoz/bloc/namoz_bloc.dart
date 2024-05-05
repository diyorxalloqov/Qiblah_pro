import 'dart:async';

import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/namoz/model/namoz_model.dart';
import 'package:qiblah_pro/modules/namoz/service/namoz_service.dart';

part 'namoz_event.dart';
part 'namoz_state.dart';

class NamozBloc extends Bloc<NamozEvent, NamozState> {
  NamozBloc() : super(const NamozState()) {
    on<GetNamozData>(_getNamozData);
    add(GetNamozData());
  }

  final NamozService _namozService = NamozService();

  Future<FutureOr<void>> _getNamozData(
      GetNamozData event, Emitter<NamozState> emit) async {
    emit(state.copyWith(status: ActionStatus.isLoading));
    try {
      List<NamozModel> res = await _namozService.getNamozData();
      emit(state.copyWith(status: ActionStatus.isSuccess, namozModel: res));
    } on Exception catch (e) {
      emit(state.copyWith(status: ActionStatus.isError, error: e.toString()));
    }
  }
}
