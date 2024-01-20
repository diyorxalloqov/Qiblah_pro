import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.24,
      margin: EdgeInsets.only(right: 18.h),
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
          color: Colors.blueGrey, borderRadius: BorderRadius.circular(12.r)),
    );
  }
}
