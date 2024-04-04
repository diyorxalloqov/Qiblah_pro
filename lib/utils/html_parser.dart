import 'package:flutter/services.dart';
import 'package:html_unescape/html_unescape_small.dart';

String extractTitleFromHtml(String htmlString) {
  final unescape = HtmlUnescape();
  final text = unescape.convert(htmlString);
  const startTag = '<p><b>';
  const endTag = '</b></p>';
  final startIndex = text.indexOf(startTag);
  final endIndex = text.indexOf(endTag, startIndex + startTag.length);
  if (startIndex != -1 && endIndex != -1) {
    return text.substring(startIndex + startTag.length, endIndex);
  }
  return '';
}

wrapWithAdaptiveHtml(String html) {
  return """
      <!DOCTYPE html>
      <html>
        <head><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
        <body style='margin: 5px; padding: 5px;'>
           <div>
           ${_loadHtmlFromAsset(html)}
           </div>
        </body>
      </html>
    """;
}

Future<String> _loadHtmlFromAsset(String htmlPath) async {
  return await rootBundle.loadString('assets/html/$htmlPath');
}
