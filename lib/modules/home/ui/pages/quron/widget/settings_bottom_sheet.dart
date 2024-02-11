import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/ui/pages/quron/widget/categories/ekran.dart';
import 'package:qiblah_pro/modules/home/ui/pages/quron/widget/categories/korsatish.dart';
import 'package:qiblah_pro/modules/home/ui/pages/quron/widget/categories/ovoz.dart';
import 'package:qiblah_pro/modules/home/ui/pages/quron/widget/categories/umumiy.dart';

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
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: context.height * 0.5,
        decoration: BoxDecoration(
            color: bottomSheetBackgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.r),
                topRight: Radius.circular(24.r))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              // padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
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
                          color: const Color(0xFFE3E6EA),
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
                      labelColor: Colors.black,
                      unselectedLabelColor: smallTextColor,
                      controller: _tabController,
                      labelStyle: TextStyle(
                          fontSize: AppSizes.size_14,
                          fontFamily: AppfontFamily.inter.fontFamily,
                          fontWeight: AppFontWeight.w_600),
                      tabs: [
                        Tab(
                          text: 'ekran'.tr(),
                        ),
                        Tab(
                          text: 'umumiy'.tr(),
                        ),
                        Tab(
                          text: 'korsatish'.tr(),
                        ),
                        Tab(
                          text: 'ovoz'.tr(),
                        ),
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

  final List<Widget> _screens = const [Ekran(), Umumiy(), Korsatish(), Ovoz()];
}
