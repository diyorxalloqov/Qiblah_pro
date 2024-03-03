import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/namoz/model/namoz_model.dart';
import 'package:qiblah_pro/modules/namoz/ui/pages/details/namoz_details_page.dart';
import 'package:qiblah_pro/modules/namoz/ui/widgets/namoz_card_widget.dart';

class JamoatNamozi extends StatelessWidget {
  final List<CategoryItems> categoryItem;
  const JamoatNamozi({super.key, required this.categoryItem});

  @override
  Widget build(BuildContext context) {
    final List<String> _titles = [
      "juma_namozi",
      "hayit_namozi",
      "musofir_namozi",
      "janoza_namozi"
    ];

    return Scaffold(
      appBar: customAppbar(context, 'jamoat_namozi'.tr()),
      body: Column(
          children: List.generate(
              4,
              (index) => NamozCardWidget(
                    icon: AppIcon.apple,
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NamozDetailsPage(
                                appBarName: _titles[index].tr(),
                                items: categoryItem[index].subCategoryItems!))),
                    title: _titles[index].tr(),
                  ))),
    );
  }
}
