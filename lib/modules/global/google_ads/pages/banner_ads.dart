import 'dart:developer';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:qiblah_pro/modules/global/google_ads/service/ads_helper.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class MainPageAds extends StatefulWidget {
  const MainPageAds({super.key});

  @override
  State<MainPageAds> createState() => _MainPageAdsState();
}

class _MainPageAdsState extends State<MainPageAds> {
  late BannerAd mainPageBanner;
  bool isMainPageBannerLoaded = false;

  @override
  void initState() {
    mainPageBanner = BannerAd(
      adUnitId: AdHelper.bannerId(),
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(onAdLoaded: (ad) {
        log("HomePage Banner Loaded!");
        isMainPageBannerLoaded = true;
        setState(() {});
      }, onAdClosed: (ad) {
        ad.dispose();
        isMainPageBannerLoaded = false;
        setState(() {});
      }, onAdFailedToLoad: (ad, err) {
        log(err.toString());
        isMainPageBannerLoaded = false;
        setState(() {});
      }),
    )..load();
    super.initState();
  }

  @override
  void dispose() {
    mainPageBanner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isMainPageBannerLoaded
        ? Container(
            color: Colors.white,
            height: mainPageBanner.size.height.toDouble(),
            child: AdWidget(ad: mainPageBanner),
          )
        : const SizedBox.shrink();
  }
}
