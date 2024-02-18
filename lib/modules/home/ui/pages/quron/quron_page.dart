import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/ui/pages/quron/categories/juzlar.dart';
import 'package:qiblah_pro/modules/home/ui/pages/quron/categories/suralar.dart';
import 'package:qiblah_pro/modules/home/ui/pages/quron/categories/tanlanganlar.dart';

class QuronPage extends StatefulWidget {
  const QuronPage({super.key});

  @override
  State<QuronPage> createState() => _QuronPageState();
}

class _QuronPageState extends State<QuronPage> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Container(
              width: 28,
              height: 28,
              decoration: ShapeDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: SvgPicture.asset(AppIcon.arrowLeft,
                  color: context.isDark ? const Color(0xffB5B9BC) : null),
            )),
        centerTitle: true,
        title: Text(
          'quron'.tr(),
          style: TextStyle(
              fontFamily: AppfontFamily.comforta.fontFamily,
              fontWeight: AppFontWeight.w_700,
              fontSize: AppSizes.size_18),
        ),
        bottom: TabBar(
            indicatorColor: primaryColor,
            indicatorWeight: 4,
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: context.isDark ? Colors.white : Colors.black,
            unselectedLabelColor:
                context.isDark ? Colors.white54 : smallTextColor,
            controller: _tabController,
            labelStyle: TextStyle(
                fontSize: AppSizes.size_14,
                fontFamily: AppfontFamily.inter.fontFamily,
                fontWeight: AppFontWeight.w_600),
            tabs: [
              Tab(
                text: 'suralar'.tr(),
              ),
              Tab(
                text: 'juzlar'.tr(),
              ),
              Tab(
                text: 'tanlanganlar'.tr(),
              ),
            ]),
      ),
      body: TabBarView(controller: _tabController, children: _screens),
    );
  }

  final List<Widget> _screens = const [
    SuralarlarPage(),
    JuzlarPage(),
    TanlanganlarPage()
  ];
}
