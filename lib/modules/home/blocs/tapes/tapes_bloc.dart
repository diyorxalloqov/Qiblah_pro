import 'dart:math';

import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:dartz/dartz.dart';

part 'tapes_event.dart';
part 'tapes_state.dart';

class TapesBloc extends Bloc<TapesEvent, TapesState> {
  TapesBloc() : super(const TapesState()) {
    on<GetTapesLenta>(_getTapes);
    add(GetTapesLenta());
  }

  /// network
  final TapesLentaService _tapesLentaService = TapesLentaService();

  /// local
  final QuronDBService _quronDBService = QuronDBService();
  final NamesDbService _namesDbService = NamesDbService();
  final ZikrDBSevice _zikrDBSevice = ZikrDBSevice();

  Future<void> _getTapes(GetTapesLenta event, Emitter<TapesState> emit) async {
    emit(state.copyWith(status: ActionStatus.isLoading));
    Either<String, TapesModel> res = await _tapesLentaService.getTapesData();
    List<OyatModel>? oyats = await _quronDBService.getAllOyat();
    List<NamesData>? names = await _namesDbService.getNames();
    List<ZikrModel>? zikrs = await _zikrDBSevice.getAllZikr();
    res.fold(
      (l) {
        try {
          if (oyats != null && names != null && zikrs != null) {
            if (oyats.isNotEmpty && zikrs.isNotEmpty && names.isNotEmpty) {
              final randomOyat = Random().nextInt(oyats.length);
              final randomnames = Random().nextInt(names.length);
              final randomzikrs = Random().nextInt(zikrs.length);
              final randomduo = Random().nextInt(zikrs.length);
              TapesModel data = TapesModel(
                verse: Verse(
                  juzNumber: oyats[randomOyat].juzNumber,
                  verseNumber: oyats[randomOyat].verseNumber,
                  meaning: oyats[randomOyat].meaning,
                  verseArabic: oyats[randomOyat].verseArabic,
                ),
                zikr: Zikr(
                  zikrTitle: zikrs[randomzikrs].zikrTitle,
                  zikrDescription: zikrs[randomzikrs].zikrDescription,
                ),
                name: Name(
                  title: names[randomnames].title,
                  description: names[randomnames].description,
                  nameId: names[randomnames].nameId,
                ),
                dua: Dua(
                  zikrTitle: zikrs[randomduo].zikrTitle,
                  zikrDescription: zikrs[randomduo].zikrDescription,
                ),
              );
              emit(state.copyWith(
                  status: ActionStatus.isSuccess, tapesModel: data));
            }
          } else {
            emit(state.copyWith(status: ActionStatus.isLoading, error: l));
          }
        } catch (e) {
          emit(state.copyWith(
              status: ActionStatus.isLoading, error: e.toString()));
        }
      },
      (r) =>
          emit(state.copyWith(status: ActionStatus.isSuccess, tapesModel: r)),
    );
  }
}
