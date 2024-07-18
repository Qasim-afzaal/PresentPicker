import 'dart:developer';

import 'package:present_picker/utils/Utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../model/scrapping_model.dart';

class AppService {
  bool scrapDataLoading = false;
  final RegExp exp =
      RegExp(r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");

  static Future<void> launchURLService(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw Exception("Unable to load the website");
    }
  }

static Future<void> launchEmailApp(String emailAddress) async {
    final Uri emailParams = Uri(
      scheme: 'mailto',
      path: emailAddress,
    );

    final String emailUrl = emailParams.toString();

    try {
      if (await canLaunch(emailUrl)) {
        await launch(emailUrl);
      } else {
        throw Exception("No email app found on the device");
      }
    } catch (e) {
      throw Exception("Failed to open the email app: $e");
    }
  }

  String matchAndCreateURL(String value) {
    /// First gets all the matches based on the Regular Expression
    List<RegExpMatch> matches = exp.allMatches(value).toList();

    String url = createURL(matches);
    return url;
  }

  Future<ScrappingModel> scrapDataFromUrl(String url) async {
    // url = Uri.encodeComponent(url);
    String baseUrl = Utils.scrapingURL + url;
    log(baseUrl);

    Uri uri = Uri.parse(Uri.encodeFull(baseUrl));

    log(uri.toString());
    try {
      var response = await http.get(uri);
      log('Scrap Model Response: ${response.body}');
      ScrappingModel scrappingModel = scrappingModelFromJson(response.body);
      return scrappingModel;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
 

  /// Function creates the URL based on the matches of Regular Expression
  String createURL(List allMatches) {
    String url = "";
    for (var element in allMatches) {
      url = url + element.group(0);
    }
    return url;
  }
}
