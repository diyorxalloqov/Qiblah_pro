import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:just_audio/just_audio.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

part 'names_event.dart';
part 'names_state.dart';

class NamesBloc extends Bloc<NamesEvent, NamesState> {
  final NamesService _namesService = NamesService();
  final AudioPlayer player = AudioPlayer();

  NamesBloc() : super(const NamesState()) {
    on<GetNamesEvent>(_getNames);
    add(GetNamesEvent());
    on<PlayNameEvent>(_playName);
  }

  // late PermissionStatus _audioPersmission;

  Future<FutureOr<void>> _getNames(
      GetNamesEvent event, Emitter<NamesState> emit) async {
    emit(state.copyWith(status: ActionStatus.isLoading));
    Either<String, NamesModel> res = await _namesService.getNames();
    res.fold(
        (l) => emit(state.copyWith(status: ActionStatus.isError, error: l)),
        (r) => emit(
            state.copyWith(status: ActionStatus.isSuccess, namesModel: r)));
  }

  Future<FutureOr<void>> _playName(
      PlayNameEvent event, Emitter<NamesState> emit) async {
    await player.setUrl(event.url);

    // _audioPersmission = await Permission.microphone.status;
    // print(_audioPersmission);

    // if (_audioPersmission.isDenied || _audioPersmission.isPermanentlyDenied) {
    //   // Request permission only if it is denied or permanently denied
    //   await Permission.microphone.request();
    //   _audioPersmission = await Permission.microphone.status;
    //   print('${Permission.microphone} status audio');
    // }

    // if (_audioPersmission.isGranted) {
    // print('audio permission granted');

    if (event.isPlaying) {
      await player.play();
      emit(state.copyWith(isPlaying: true));
      await for (var playerState in player.playerStateStream) {
        if (playerState.processingState == ProcessingState.completed) {
          await player.stop();
          emit(state.copyWith(isPlaying: false));
          break;
        }
      }
    } else {
      await player.stop();
      emit(state.copyWith(isPlaying: false));
    }
  }
}
