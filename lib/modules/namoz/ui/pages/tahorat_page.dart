import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/namoz/model/namoz_model.dart';
import 'package:qiblah_pro/modules/namoz/ui/pages/details/namoz_details_page.dart';
import 'package:qiblah_pro/modules/namoz/ui/widgets/namoz_card_widget.dart';

class LearnTahorat extends StatelessWidget {
  final List<CategoryItems> categoryItem;
  const LearnTahorat({super.key, required this.categoryItem});

  @override
  Widget build(BuildContext context) {
    final List<String> _titles = [
      "tahorat_olish",
      "tahorat_nima",
      "tahorat_buzadigan_holat",
      "gusl",
      "tayammum"
    ];

    return Scaffold(
      appBar: customAppbar(context, 'tahorat_olishni_organish1'.tr()),
      body: Column(
          children: List.generate(
              5,
              (index) => NamozCardWidget(
                    icon: SvgPicture.asset(AppIcon.tahoratIcon),
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
