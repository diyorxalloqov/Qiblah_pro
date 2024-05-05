import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:shimmer/shimmer.dart';

class TapesShimmer extends StatelessWidget {
  const TapesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 4,
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(18.0.h),
          margin: EdgeInsets.only(top: 18.h, right: 12.w, left: 30.w),
          decoration: BoxDecoration(
              color: context.isDark ? homeBlackMainColor : Colors.white,
              borderRadius: BorderRadius.circular(12.r)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Shimmer.fromColors(
                      baseColor: primaryColor.withOpacity(0.2),
                      highlightColor: Colors.white54,
                      child:
                          Container(color: Colors.red, height: 20, width: 60)),
                  Shimmer.fromColors(
                      baseColor: context.isDark
                          ? Colors.black12
                          : const Color(0xFFE0E3E7),
                      highlightColor: Colors.white54,
                      child:
                          Container(color: Colors.red, height: 20, width: 70)),
                ],
              ),
              SpaceHeight(height: 18.h),
              Shimmer.fromColors(
                  baseColor:
                      context.isDark ? Colors.black38 : const Color(0xFFE0E3E7),
                  highlightColor: Colors.white54,
                  child: Container(
                      color: Colors.red, height: 30, width: double.infinity)),
              SpaceHeight(height: 10.h),
              Shimmer.fromColors(
                  baseColor:
                      context.isDark ? Colors.black38 : const Color(0xFFE0E3E7),
                  highlightColor: Colors.white54,
                  child: Container(
                      color: Colors.red, height: 100, width: double.infinity)),
              const SpaceHeight(),
              const SpaceHeight(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Shimmer.fromColors(
                    baseColor: context.isDark
                        ? Colors.black38
                        : const Color(0xFFE0E3E7),
                    highlightColor: Colors.white54,
                    child: CircleAvatar(
                      radius: 16.r,
                      backgroundColor: context.isDark
                          ? circleAvatarBlackColor
                          : circleAvatarColor,
                      child: Center(
                        child: SvgPicture.asset(AppIcon.bookmark,
                            color: context.isDark
                                ? const Color(0xffB5B9BC)
                                : null),
                      ),
                    ),
                  ),
                  SpaceWidth(width: 18.w),
                  Shimmer.fromColors(
                    baseColor: context.isDark
                        ? Colors.black38
                        : const Color(0xFFE0E3E7),
                    highlightColor: Colors.white54,
                    child: CircleAvatar(
                      radius: 16.r,
                      backgroundColor: context.isDark
                          ? circleAvatarBlackColor
                          : circleAvatarColor,
                      child: Center(
                        child: SvgPicture.asset(AppIcon.share,
                            color: context.isDark
                                ? const Color(0xffB5B9BC)
                                : null),
                      ),
                    ),
                  ),
                  SpaceWidth(width: 18.w),
                  Shimmer.fromColors(
                    baseColor: context.isDark
                        ? Colors.black38
                        : const Color(0xFFE0E3E7),
                    highlightColor: Colors.white54,
                    child: CircleAvatar(
                      radius: 16.r,
                      backgroundColor: primaryColor,
                      child: Center(
                        child: SvgPicture.asset(AppIcon.play),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
