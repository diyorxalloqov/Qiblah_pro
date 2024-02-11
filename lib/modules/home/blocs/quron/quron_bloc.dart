import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

part 'quron_event.dart';
part 'quron_state.dart';

class QuronBloc extends Bloc<QuronEvent, QuronState> {
  QuronBloc() : super(const QuronState()) {}
}
