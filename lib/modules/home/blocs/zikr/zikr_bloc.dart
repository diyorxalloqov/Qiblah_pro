import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

part 'zikr_event.dart';
part 'zikr_state.dart';

class ZikrBloc extends Bloc<ZikrEvent, ZikrState> {
  ZikrBloc() : super(const ZikrState());
}
