import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/namoz/ui/widgets/namoz_card_widget.dart';

class LearnNamoz extends StatelessWidget {
  const LearnNamoz({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> _titles = [
      'azon'.tr(),
      'bomdod'.tr(),
      '${'peshin'.tr()} ${'namozi'.tr()}',
      '${'asr'.tr()} ${'namozi'.tr()}',
      '${'shom'.tr()} ${'namozi'.tr()}',
      '${'xufton'.tr()} ${'namozi'.tr()}',
      '${'vitr'.tr()} ${'namozi'.tr()}',
      'qazo'.tr(),
    ];
    final List<String> icon = [
      AppIcon.azon,
      AppIcon.bomdod,
      AppIcon.peshin,
      AppIcon.asr,
      AppIcon.shom,
      AppIcon.xufton_vitr,
      AppIcon.xufton_vitr,
      AppIcon.qazo
    ];
    return Scaffold(
      appBar: customAppbar(context, 'namoz_oqishni_organish1'.tr()),
      body: Column(
          children: List.generate(
              8,
              (index) => NamozCardWidget(
                    icon: icon[index],
                    onTap: () {
                      Navigator.pushNamed(context, 'namozSectionScreen');
                    },
                    title: _titles[index],
                  ))),
    );
  }
}
