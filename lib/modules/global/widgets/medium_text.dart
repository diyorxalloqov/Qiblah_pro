import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class MediumText extends StatelessWidget {
  final String text;
  const MediumText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
    );
  }
}
