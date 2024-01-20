part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class GetimageEvent extends ProfileEvent {
  const GetimageEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

final class PickImageEvent extends ProfileEvent {
  final ImageSource imageSource;

  const PickImageEvent({required this.imageSource});
  @override
  // TODO: implement props
  List<Object> get props => [imageSource];
}
