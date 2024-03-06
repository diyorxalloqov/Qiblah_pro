import 'dart:async';

import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/profile/model/profile_model.dart';
import 'package:qiblah_pro/modules/profile/service/profile_service.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<PickImageEvent>(_pickImage);
    on<GetUserData>(_getUserdata);
    on<ChangeUserDataEvent>(_changeUserData);
    on<ChangePasswordEvent>(_changePassword);
    on<DeleteAccauntEvent>(_deleteAccaunt);
    on<LogoutEvent>(_loggout);
    on<GetUserdataForEdit>(_getUserdataForEdit);
  }

  final ProfileService _profileService = ProfileService();

  Future<FutureOr<void>> _pickImage(
      PickImageEvent event, Emitter<ProfileState> emit) async {
    try {
      final image = await ImagePicker().pickImage(source: event.source);
      print("working");
      if (image != null) {
        print('hello');
        final img = File(image.path);
        emit(state.copyWith(imagePath: img.path, isChangeImage: true));
        print(img);
        print(img.path);
        add(GetUserdataForEdit());
      } else {
        print('object');
        emit(state.copyWith(isChangeImage: false));
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
      emit(state.copyWith(error: e.toString()));
    }
  }

  FutureOr<void> _getUserdataForEdit( // if image get showing profile and restart not showing //
      GetUserdataForEdit event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
        imagePath: state.imagePath,
        userData: UserData(
            userName: StorageRepository.getString(Keys.name),
            userPhoneNumber: StorageRepository.getString(Keys.phone),
            userGender: StorageRepository.getBool(Keys.isMan) == true
                ? "erkak"
                : "ayol")));
  }

  FutureOr<void> _getUserdata(GetUserData event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
        imagePath: StorageRepository.getString(Keys.image),
        userData: UserData(
            userName: StorageRepository.getString(Keys.name),
            userPhoneNumber: StorageRepository.getString(Keys.phone),
            userGender: StorageRepository.getBool(Keys.isMan) == true
                ? "erkak"
                : "ayol")));
  }

  Future<FutureOr<void>> _changeUserData(
      ChangeUserDataEvent event, Emitter<ProfileState> emit) async {
    await _profileService.changeName(UserData(
        userId: StorageRepository.getString(Keys.userId),
        userName: event.name,
        userGender: event.gender,
        userPhoneNumber: event.phone));
    await StorageRepository.putBool(Keys.isMan, event.gender == 'erkak');
    await StorageRepository.putString(Keys.name, event.name);
    await StorageRepository.putString(Keys.phone, event.phone);

    if (state.isChangeImage) {
      await StorageRepository.putString(Keys.image, state.imagePath);
      await _profileService.putImage(state.imagePath);
    }
    emit(state.copyWith(
        userData: UserData(
            userName: event.name,
            userGender: event.gender,
            userPhoneNumber: event.phone)));
  }

  Future<FutureOr<void>> _changePassword(
      ChangePasswordEvent event, Emitter<ProfileState> emit) async {
    await _profileService.changeContact(UserData(
        userPassword: event.password,
        userId: StorageRepository.getString(Keys.userId),
        userEmail: '', // not have
        userPhoneNumber: StorageRepository.getString(Keys.phone)));
  }

  Future<FutureOr<void>> _deleteAccaunt(
      DeleteAccauntEvent event, Emitter<ProfileState> emit) async {
    await StorageRepository.deleteString(Keys.token);
    await _profileService.deleteUser();
  }

  Future<FutureOr<void>> _loggout(
      LogoutEvent event, Emitter<ProfileState> emit) async {
    await StorageRepository.deleteString(Keys.token);
  }
}
