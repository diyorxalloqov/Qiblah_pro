import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class TimeItem extends StatelessWidget {
  final VoidCallback volumeOnTap;
  final String namozName;
  final String time;
  const TimeItem(
      {super.key,
      required this.namozName,
      required this.time,
      required this.volumeOnTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            namozName,
            style: TextStyle(
              color: Colors.white,
              fontSize: AppSizes.size_16,
              fontFamily: AppfontFamily.comforta.fontFamily,
              fontWeight: AppFontWeight.w_400,
            ),
          ),
          Row(
            children: [
              Text(
                time,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: AppSizes.size_16,
                    fontFamily: AppfontFamily.comforta.fontFamily,
                    fontWeight: AppFontWeight.w_400),
              ),
              const SpaceWidth(),
              IconButton(
                  onPressed: volumeOnTap,
                  icon: SvgPicture.asset(AppIcon.volume))
            ],
          )
        ],
      ),
    );
  }
}
