import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/namoz/model/namoz_model.dart';
import 'package:qiblah_pro/modules/namoz/ui/pages/details/web_view_page.dart';
import 'package:qiblah_pro/modules/namoz/ui/widgets/namoz_details_card_widget.dart';

class NamozDetailsPage extends StatelessWidget {
  final String appBarName;
  final List<SubCategoryItems> items;
  const NamozDetailsPage(
      {super.key, required this.appBarName, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context, appBarName),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (contexr, index) {
            return NamozDetailsCardWidget(
                title: items[index].name ?? '',
                index: index + 1,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WebViewScreenWidget(
                              html: items[index].contentPath.toString(),
                              title: appBarName,
                              items: items)));
                });
          }),
    );
  }
}
