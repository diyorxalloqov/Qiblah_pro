part of 'profile_bloc.dart';

@immutable
class ProfileState extends Equatable {
  final ActionStatus status;
  final String imagePath;

  const ProfileState({
    this.imagePath = '',
    this.status = ActionStatus.isInitial,
  });

  ProfileState copyWith({
    ActionStatus? status,
    String? imagePath,
    bool? isImageCamera,
  }) {
    return ProfileState(
      imagePath: imagePath ?? this.imagePath,
      status: status ?? this.status,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, imagePath];
}
