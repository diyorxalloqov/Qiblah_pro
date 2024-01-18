import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class HighText extends StatelessWidget {
  final String text;
  const HighText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 28, fontWeight: FontWeight.w700, color: Colors.black),
    );
  }
}
