import 'dart:async';

import 'package:qiblah_pro/core/db/db_service.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/global/model/user_model.dart';
import 'package:sqflite/sqflite.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState()) {
    on<UserDataSaveEvent>(_userdata);
    on<UserdataGetEvent>(_userdataGet);
  }
  DBService dbService = DBService();

  Future<FutureOr<void>> _userdata(
      UserDataSaveEvent event, Emitter<UserState> emit) async {
    try {
      await dbService.insertUserdata(event.user);
      emit(state.copyWith(status: ActionStatus.isSuccess));
    } on DatabaseException catch (e) {
      emit(state.copyWith(status: ActionStatus.isError, error: e.toString()));
    }
  }

  Future<FutureOr<void>> _userdataGet(
      UserdataGetEvent event, Emitter<UserState> emit) async {
    try {
      UserModel? data = await dbService.getUserData();
      emit(state.copyWith(status: ActionStatus.isSuccess, userModel: data));
    } on DatabaseException catch (e) {
      emit(state.copyWith(status: ActionStatus.isError, error: e.toString()));
    }
  }
}
