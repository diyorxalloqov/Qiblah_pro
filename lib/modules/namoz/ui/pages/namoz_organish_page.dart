import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/namoz/model/namoz_model.dart';
import 'package:qiblah_pro/modules/namoz/ui/pages/details/namoz_details_page.dart';
import 'package:qiblah_pro/modules/namoz/ui/widgets/namoz_card_widget.dart';

class LearnNamoz extends StatelessWidget {
  final List<CategoryItems> categoryItem;
  const LearnNamoz({super.key, required this.categoryItem});

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
    final List<String> _icon = [
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
              categoryItem.length,
              (index) => NamozCardWidget(
                    icon: _icon[index],
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NamozDetailsPage(
                                appBarName: _titles[index],
                                items: categoryItem[index].subCategoryItems!))),
                    title: _titles[index],
                  ))),
    );
  }
}
