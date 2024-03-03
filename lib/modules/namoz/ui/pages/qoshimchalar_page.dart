import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/namoz/model/namoz_model.dart';
import 'package:qiblah_pro/modules/namoz/ui/pages/details/namoz_details_page.dart';
import 'package:qiblah_pro/modules/namoz/ui/widgets/namoz_card_widget.dart';

class Qoshimchalar extends StatelessWidget {
  final List<CategoryItems> categoryItem;

  const Qoshimchalar({super.key, required this.categoryItem});

  @override
  Widget build(BuildContext context) {
    final List<String> _titles = [
      "poklanish",
      "namozga_oid_savol",
      "sura_va_duolar",
      "olti_diniy_kalima",
      "salovotlar",
      "qurondan_duolar",
      "allohning sifatlari",
      "qirq_farz"
    ];

    return Scaffold(
      appBar: customAppbar(context, 'qoshimchalar'.tr()),
      body: Column(
          children: List.generate(
              8,
              (index) => NamozCardWidget(
                    icon: AppIcon.qoshimchalar,
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
