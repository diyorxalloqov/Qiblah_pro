import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _currentIndex = 0;
  final List<Widget> _screens = const [HomePage(), NamozPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: AppFontWeight.w_400,
        ),
        fixedColor: context.isDark ? Colors.white : Colors.black,
        selectedLabelStyle: TextStyle(
          color: highTextColor,
          fontWeight: AppFontWeight.w_600,
        ),
        onTap: (v) {
          _currentIndex = v;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppIcon.home, color: smallTextColor),
            activeIcon: Column(
              children: [
                Container(
                    width: 37,
                    height: 4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.r),
                            bottomRight: Radius.circular(10.r)),
                        color: primaryColor)),
                const SpaceHeight(),
                SvgPicture.asset(AppIcon.home),
              ],
            ),
            label: 'nav_asosiy'.tr(),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppIcon.namoz),
            activeIcon: Column(
              children: [
                Container(
                    width: 37,
                    height: 4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.r),
                            bottomRight: Radius.circular(10.r)),
                        color: primaryColor)),
                const SpaceHeight(),
                SvgPicture.asset(AppIcon.namoz, color: primaryColor),
              ],
            ),
            label: 'nav_namoz'.tr(),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppIcon.profile),
            label: 'nav_profile'.tr(),
            activeIcon: Column(
              children: [
                Container(
                    width: 37,
                    height: 4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.r),
                            bottomRight: Radius.circular(10.r)),
                        color: primaryColor)),
                const SpaceHeight(),
                SvgPicture.asset(AppIcon.profile, color: primaryColor),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
