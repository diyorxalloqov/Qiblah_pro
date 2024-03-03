import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/namoz/model/namoz_model.dart';
import 'package:qiblah_pro/modules/namoz/ui/pages/details/namoz_details_page.dart';
import 'package:qiblah_pro/modules/namoz/ui/widgets/namoz_card_widget.dart';

class Mistakes extends StatelessWidget {
  final List<CategoryItems> categoryItem;
  const Mistakes({super.key, required this.categoryItem});

  @override
  Widget build(BuildContext context) {
    final List<String> _titles = [
      "namozni_buzadigan_hollar",
      "niyat",
      "takbir",
      "qiyom",
      "ruku",
      "sajda",
      "qada",
      "salom"
    ];
    return Scaffold(
      appBar: customAppbar(context, 'namozdagi_hatoliklar1'.tr()),
      body: Column(
          children: List.generate(
              8,
              (index) => NamozCardWidget(
                    icon: AppIcon.xatolik_icon,
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
