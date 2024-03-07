import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/namoz/model/namoz_model.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class WebViewScreenWidget extends StatefulWidget {
  final String title;
  final int currentIndex;
  final List<SubCategoryItems> items;

  const WebViewScreenWidget(
      {Key? key,
      required this.currentIndex,
      required this.items,
      required this.title})
      : super(key: key);

  @override
  State<WebViewScreenWidget> createState() => _WebViewScreenWidgetState();
}

class _WebViewScreenWidgetState extends State<WebViewScreenWidget> {
  late WebViewController _webViewController;
  late PageController _pageController;
  late int _currentPage;
  late Set<Factory<OneSequenceGestureRecognizer>> _gestureRecognizers;
  double fontSize = 20.0;

  @override
  void initState() {
    _currentPage = widget.currentIndex;
    _pageController = PageController(initialPage: _currentPage);
    _gestureRecognizers =
        _gestureRecognizers = {Factory(() => EagerGestureRecognizer())};
    _initializeWebView();
    super.initState();
  }

  Future<void> _initializeWebView() async {
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{
          PlaybackMediaTypes.audio
        },
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }
    _webViewController = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(true);
    if (_webViewController.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(false);
      (_webViewController.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(true);
    }

    await _loadHtmlContent(widget.items[_currentPage].contentPath.toString());
  }

  @override
  void dispose() {
    super.dispose();
  }

  late Widget _currentWebView = WebViewWidget(
    controller: _webViewController,
    gestureRecognizers: _gestureRecognizers,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
            widget.title,
            style: TextStyle(
                fontFamily: AppfontFamily.comforta.fontFamily,
                fontWeight: AppFontWeight.w_700,
                fontSize: AppSizes.size_18),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      isDismissible: true,
                      isScrollControlled: true,
                      context: context,
                      builder: (context) =>
                          StatefulBuilder(builder: (context, setStates) {
                            return Container(
                                height: context.height * 0.2,
                                decoration: BoxDecoration(
                                    color: context.isDark
                                        ? homeBackColor
                                        : scaffoldColor,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: context.isDark
                                                  ? Colors.black
                                                  : Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(24.r),
                                                  topRight:
                                                      Radius.circular(24.r)),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.w,
                                                      vertical: 18.h),
                                                  child: MediumText(
                                                      text: 'sozlamalar'.tr()),
                                                ),
                                                Container(
                                                  width: 52,
                                                  height: 4,
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  decoration: ShapeDecoration(
                                                    color: context.isDark
                                                        ? const Color(
                                                            0xff232C37)
                                                        : const Color(
                                                            0xffE3E7EA),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              650),
                                                    ),
                                                  ),
                                                ),
                                                const SpaceWidth(),
                                                const SpaceWidth(),
                                                const SpaceWidth(),
                                              ],
                                            ),
                                          ),
                                          const SpaceHeight(),
                                          const SpaceHeight(),
                                          Container(
                                            color: context.isDark
                                                ? Colors.black
                                                : Colors.white,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.w),
                                                  child: Text(
                                                    "matn_olchami".tr(),
                                                    style: TextStyle(
                                                        fontSize:
                                                            AppSizes.size_14,
                                                        fontWeight:
                                                            AppFontWeight.w_400,
                                                        fontFamily:
                                                            AppfontFamily.inter
                                                                .fontFamily),
                                                  ),
                                                ),
                                                Slider(
                                                    value: fontSize,
                                                    min: 20,
                                                    max: 60,
                                                    divisions: 10,
                                                    activeColor: primaryColor,
                                                    thumbColor: Colors.white,
                                                    label:
                                                        '${fontSize.toInt()}',
                                                    onChanged: (v) {
                                                      fontSize = v;
                                                      setStates(() {});
                                                      _loadHtmlContent(widget
                                                          .items[_currentPage]
                                                          .contentPath
                                                          .toString());
                                                    }),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ));
                          }));
                },
                icon: SvgPicture.asset(AppIcon.filter,
                    color: context.isDark ? Colors.white : null))
          ],
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: widget.items.length,
          onPageChanged: (value) async {
            setState(() {
              _currentWebView = WebViewWidget(
                controller: _webViewController,
                gestureRecognizers: _gestureRecognizers,
              );
              _currentPage = value;
            });
            await _loadHtmlContent(
                widget.items[_currentPage].contentPath.toString());
          },
          itemBuilder: (context, index) {
            if (index == _currentPage) {
              return _currentWebView;
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          height: 70.h,
          color: context.isDark ? const Color(0xff16171B) : Colors.white,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => _pageController.previousPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeIn),
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: ShapeDecoration(
                    color: const Color(0xffF4F8FA),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: SvgPicture.asset(AppIcon.arrowLeft,
                      color: const Color(0xff374957)),
                ),
              ),
              Text("${_currentPage + 1}/${widget.items.length}"),
              GestureDetector(
                onTap: () => _pageController.nextPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeIn),
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: ShapeDecoration(
                    color: const Color(0xffF4F8FA),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: SvgPicture.asset(AppIcon.arrowRight1,
                      color: const Color(0xff374957)),
                ),
              )
            ],
          ),
        ));
  }

  Future<void> _loadHtmlContent(String htmlPath) async {
    final htmlContent = await _loadHtmlFromAsset(htmlPath);
    final wrappedHtml = wrapWithAdaptiveHtml(htmlContent);
    _webViewController.loadHtmlString(wrappedHtml);
  }

  Future<String> _loadHtmlFromAsset(String htmlPath) async {
    return await rootBundle.loadString('assets/html/$htmlPath');
  }

  String wrapWithAdaptiveHtml(String html) {
    String hexBackgroundColor = context.isDark ? '#16171B' : '#F4F7FA';
    String textColor = context.isDark ? 'white' : 'black';
    String audioBackgroundColor = context.isDark ? '#9FA3A6' : '#FFFFFF';

    return """
    <!DOCTYPE html>
    <html>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
          body {
            margin: 5px;
            padding: 5px;
            background-color: $hexBackgroundColor;
            color: $textColor;
          }
          p {
            font-size: ${fontSize.toInt()}px;
            color: $textColor; // Set the text color for all <p> tags
          }
          audio::-webkit-media-controls-panel {
            background-color: $audioBackgroundColor;
            padding: 10px;
          }
        </style>
      </head>
      <body>
         <div>
         $html
         </div>
      </body>
    </html>
  """;
  }
}
