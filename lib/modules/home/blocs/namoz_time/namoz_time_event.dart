// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'namoz_time_bloc.dart';

abstract class NamozTimeEvent extends Equatable {
  const NamozTimeEvent();

  @override
  List<Object> get props => [];
}

class CurrentNamozTimes extends NamozTimeEvent {
  const CurrentNamozTimes();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ScheduleNotificationEvent extends NamozTimeEvent {
  final NamozEnum namoz;
  const ScheduleNotificationEvent({required this.namoz});
  @override
  // TODO: implement props
  List<Object> get props => [namoz];
}

class LoadSettings extends NamozTimeEvent {
  @override
  List<Object> get props => [];
}

class ChangeSettings extends NamozTimeEvent {
  final dynamic newValue;
  const ChangeSettings({required this.newValue});
  @override
  List<Object> get props => [newValue];
}

class LocationSaveEvent extends NamozTimeEvent {
  final double lat;
  final double long;
  final String capital;
  const LocationSaveEvent({required this.lat,required this.capital, required this.long});
  @override
  // TODO: implement props
  List<Object> get props => [lat, long,capital];
}
