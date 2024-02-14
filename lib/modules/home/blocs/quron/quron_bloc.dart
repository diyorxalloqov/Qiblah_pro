import 'dart:async';

import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/models/quron_model.dart';

part 'quron_event.dart';
part 'quron_state.dart';

class QuronBloc extends Bloc<QuronEvent, QuronState> {
  QuronBloc() : super(const QuronState()) {
    on<QuronSurahGetEvent>(_getSurah);
  }
  final QuronService _quronService = QuronService();

  FutureOr<void> _getSurah(
      QuronSurahGetEvent event, Emitter<QuronState> emit) {
        
      }
}
