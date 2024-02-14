import 'dart:async';

import 'package:qiblah_pro/core/db/user_db_service.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState()) {
    on<UserDataSaveEvent>(_userdata);
    on<UserdataGetEvent>(_userdataGet);
    add(UserdataGetEvent());
  }
  final UserDBService _userDBService = UserDBService();

  Future<FutureOr<void>> _userdata(
      UserDataSaveEvent event, Emitter<UserState> emit) async {
    try {
      await _userDBService.insertUserdata(event.user);
      emit(state.copyWith(status: ActionStatus.isSuccess));
    } on DatabaseException catch (e) {
      emit(state.copyWith(status: ActionStatus.isError, error: e.toString()));
    }
  }

  Future<FutureOr<void>> _userdataGet(
      UserdataGetEvent event, Emitter<UserState> emit) async {
    try {
      UserModel? data = await _userDBService.getUserData();
      emit(state.copyWith(status: ActionStatus.isSuccess, userModel: data));
    } on DatabaseException catch (e) {
      emit(state.copyWith(status: ActionStatus.isError, error: e.toString()));
    }
  }
}
