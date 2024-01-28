import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class NamozSectionScreen extends StatelessWidget {
  const NamozSectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context, 'namoz_oqishni_organish1'.tr()),
      body: Column(
        children: [
          // Container(
          //             width: 28,
          //             height: 28,
          //             decoration: ShapeDecoration(
          // color: primaryColor,
          // shape: const StarBorder(
          //   points: 8,
          //   innerRadiusRatio: 0.84,
          // ),
          //             ),
          //             child: Center(
          //   child: Text(
          // '2',
          // style: TextStyle(
          //   color: Colors.white,
          //   fontSize: 13,
          //   fontWeight: AppFontWeight.w_500,
          // ),
          //             )),
          //           )
        ],
      ),
    );
  }
}
