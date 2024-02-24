import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/ui/pages/quron/widget/categories/ekran.dart';
import 'package:qiblah_pro/modules/home/ui/pages/quron/widget/categories/korsatish.dart';
import 'package:qiblah_pro/modules/home/ui/pages/quron/widget/categories/ovoz.dart';

showSettingBottomSheet(BuildContext context) {
  showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (context) => const SettingsPage());
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: context.height * 0.55,
        decoration: BoxDecoration(
            color: context.isDark ? homeBackColor : bottomSheetBackgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.r),
                topRight: Radius.circular(24.r))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: context.isDark
                    ? bottomSheetBackgroundBlackColor
                    : bottomSheetBackgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 18.h),
                        child: MediumText(text: 'sozlamalar'.tr()),
                      ),
                      Container(
                        width: 52,
                        height: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: ShapeDecoration(
                          color: context.isDark
                              ? const Color(0xff232C37)
                              : const Color(0xffE3E7EA),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(650),
                          ),
                        ),
                      ),
                      const SpaceWidth(),
                      const SpaceWidth(),
                    ],
                  ),
                  TabBar(
                      indicatorColor: primaryColor,
                      indicatorWeight: 4,
                      dividerColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelColor: context.isDark ? Colors.white : Colors.black,
                      unselectedLabelColor: smallTextColor,
                      controller: _tabController,
                      labelStyle: TextStyle(
                          fontSize: AppSizes.size_14,
                          fontFamily: AppfontFamily.inter.fontFamily,
                          fontWeight: AppFontWeight.w_600),
                      tabs: [
                        Tab(text: 'ekran'.tr()),
                        Tab(text: 'korsatish'.tr()),
                        Tab(text: 'ovoz'.tr()),
                      ]),
                ],
              ),
            ),
            const SpaceHeight(),
            Expanded(
                child:
                    TabBarView(controller: _tabController, children: _screens)),
          ],
        ));
  }

  final List<Widget> _screens = const [Ekran(), Korsatish(), Ovoz()];
}
