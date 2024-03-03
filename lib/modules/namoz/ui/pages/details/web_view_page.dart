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
  final String html;
  final List<SubCategoryItems> items;

  const WebViewScreenWidget(
      {Key? key, required this.html, required this.items, required this.title})
      : super(key: key);

  @override
  State<WebViewScreenWidget> createState() => _WebViewScreenWidgetState();
}

class _WebViewScreenWidgetState extends State<WebViewScreenWidget> {
  late WebViewController _webViewController;
  late PageController _pageController;

  late Set<Factory<OneSequenceGestureRecognizer>> _gestureRecognizers;
  @override
  void initState() {
    _pageController = PageController();
    _gestureRecognizers =
        _gestureRecognizers = {Factory(() => EagerGestureRecognizer())};
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
          allowsInlineMediaPlayback: true,
          mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{
            PlaybackMediaTypes.audio
          });
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
    _loadHtmlContent(widget.html); // Load HTML content
    super.initState();
  }

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppbar(context, widget.title),
        body: PageView.builder(
          controller: _pageController,
          itemCount: widget.items.length,
          onPageChanged: (value) {
            _currentPage = value;
            setState(() {});
          },
          itemBuilder: (context, index) {
            return WebViewWidget(
                controller: _webViewController,
                gestureRecognizers: _gestureRecognizers);
          },
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 1,
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
                      color: context.isDark ? const Color(0xffB5B9BC) : null),
                ),
              ),
              Text("$_currentPage/${widget.items.length}"),
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
                      color: context.isDark
                          ? const Color(0xffB5B9BC)
                          : const Color(0xff374957)),
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
    return """
      <!DOCTYPE html>
      <html>
        <head><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
        <body style='margin: 5px; padding: 5px;'>
           <div>
           $html
           </div>
        </body>
      </html>
    """;
  }
}
