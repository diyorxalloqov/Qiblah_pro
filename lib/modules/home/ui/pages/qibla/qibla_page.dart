import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/ui/pages/qibla/google_map.dart';

class QiblaPage extends StatelessWidget {
  const QiblaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context, 'qibla'.tr()),
      body:Column(
        children: [
          SizedBox(
            height: context.height*0.4,
            child: SmallGoogleMap(),
          ),
          
        ],
      )
    );
  }
}