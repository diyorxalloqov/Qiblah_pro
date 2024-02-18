// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'namoz_time_bloc.dart';

abstract class NamozTimeEvent extends Equatable {
  const NamozTimeEvent();

  @override
  List<Object> get props => [];
}

class TodayNamozTimes extends NamozTimeEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CurrentMonthNamozTimes extends NamozTimeEvent {
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

class NextDayNamozTimeEvent extends NamozTimeEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class PreviousDayNamozTimeEvent extends NamozTimeEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
