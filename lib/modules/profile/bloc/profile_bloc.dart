import 'dart:async';

import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<GetimageEvent>(_getImage);
    add(const GetimageEvent());
    on<PickImageEvent>(_pickImage);
  }

  Future<FutureOr<void>> _getImage(
      GetimageEvent event, Emitter<ProfileState> emit) async {
    String? imagePath =
        await const FlutterSecureStorage().read(key: Keys.image);

    if (imagePath == null || imagePath.isEmpty) {
      imagePath = ImagePickerService.selectedImage?.path ?? '';
      emit(state.copyWith(imagePath: imagePath));
    }

    emit(state.copyWith(imagePath: imagePath));
  }

  Future<FutureOr<void>> _pickImage(
      PickImageEvent event, Emitter<ProfileState> emit) async {
    await ImagePickerService.pickImage(event.imageSource);
    emit(state.copyWith(imagePath: ImagePickerService.selectedImage?.path));
  }
}
