part of 'profile_bloc.dart';

@immutable
class ProfileState extends Equatable {
  final ActionStatus status;
  final String imagePath;
  final bool isChangeImage;
  final String error;
  final UserData? userData;

  const ProfileState({
    this.imagePath = '',
    this.isChangeImage = false,
    this.error = '',
    this.userData,
    this.status = ActionStatus.isInitial,
  });

  ProfileState copyWith(
      {ActionStatus? status,
      bool? isChangeImage,
      String? imagePath,
      UserData? userData,
      String? error}) {
    return ProfileState(
        imagePath: imagePath ?? this.imagePath,
        status: status ?? this.status,
        userData: userData,
        isChangeImage: isChangeImage ?? this.isChangeImage,
        error: error ?? this.error);
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [status, imagePath, error, isChangeImage, userData];
}
