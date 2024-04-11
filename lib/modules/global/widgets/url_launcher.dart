import 'package:url_launcher/url_launcher.dart';

Future<void> urlLauncher(String url) async {
  final Uri _url = Uri.parse(url);

  if (!await launchUrl(_url)) {
    print('Could not launch $_url');
    throw Exception('Could not launch $_url');
  }
}
