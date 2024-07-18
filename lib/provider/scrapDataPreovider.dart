// ignore_for_file: unnecessary_string_interpolations, unused_field

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dome;
import 'package:html/parser.dart' as parser;
import 'package:present_picker/model/search_model.dart';

import '../service/callApi.dart';
import '../utils/Utils.dart';

enum WebViewStatus {
  webView,
  Success,
  Loading,
  Failure,
  scarpData,
}

class ScrapView_Model with ChangeNotifier {
  WebViewStatus _webViewScreenStatus = WebViewStatus.webView;
  WebViewStatus get webViewScreenStatus => _webViewScreenStatus;

  String? _title;
  String? get title => _title;

  String? _price;
  String? get price => _price;

  String? _imgUrl;
  String? get imgUrl => _imgUrl;

  String? _intrestPrice;
  String? get intrestPrice => _intrestPrice;

  String? _scrappingError;
  String? get scrappingError => _scrappingError;

  final TextEditingController _searchController = TextEditingController();
  List<SearchResult> _searchResults = [];

  Future<bool> scrappingAPI(String Url) async {
    print("Yrllllllll$Url");

    var url = Utils.scrappingURL;
    var body = {"url": Url};

    // var response = await http.post(Uri.parse(url), body: body);
    var res = await callAPI2(body, url, "");
    print("...............$res");
    if (res["status"] != 200) {
      //  _scrapStatus = ScrapStatus.Failure;

      // _webViewScreenStatus = WebViewStatus.Failure;

      _scrappingError = res["message"];

      notifyListeners();
      return false;
    } else {
      _title = res["title"];
      _price = res["price"];
      _imgUrl = res["image"];

      print("this is data response $_title..... $_price....$_imgUrl");

      notifyListeners();
      return true;
    }
  }

  void handleAppLifecycleState(AppLifecycleState? state) async {
    if (state == AppLifecycleState.resumed) {
      notifyListeners();
    }
  }

  Future<bool> getDataFromWebForSephora(String url) async {
    print("this is urlllllllll $url");

    final response = await http.get(Uri.parse(url));

    print("this is data${response.body.toString()}");

    if (response.statusCode == 200) {
      dome.Document document = parser.parse(response.body.toString());

      final productElement = document.querySelector('[data-at="product_name"]');
      if (productElement != null) {
        final productName = productElement.text;
        print(productName);
        _title = productName;

        final priceElement = document.querySelector('.css-18jtttk > b');
        final price = priceElement?.text;
        _price = price!;
        print(price);
        final element = document.getElementsByClassName('css-yq9732').first;
        final sourceTag = element.getElementsByTagName('source').first;
        final srcSets = sourceTag.attributes['srcset'];
        final src = srcSets!.split(' ').first;
        final image = src.split('?').first;
        print('src: $image');
        _imgUrl = image;

        // WebViewUrlScreen();

        notifyListeners();
      }
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getDataFromWebForlululemon(String Url) async {
    print("this is urlllll $Url");

    try {
      final response =
          await http.get(Uri.parse(Url)).timeout(const Duration(seconds: 15));
      print("asasasa$response");
      if (response.statusCode == 200) {
        dome.Document document = parser.parse(response.body.toString());

        if (Url.length > 29) {
          final element = document
              .getElementsByClassName('OneLinkNoTx product-title_title__i8NUw')
              .first;
          print("elelmennt $element");

          final name = element.text;
          print('Name: $name');

          _title = name!;

          final elements =
              document.getElementsByClassName('price-1jnQj price').first;
          final price = elements.text;
          print('Price: $price');
          _price = price!;

          final pictureElement = document.getElementsByTagName('picture').first;
          final imgElement = pictureElement.getElementsByTagName('img').first;
          final srcSet = imgElement.attributes['srcset'];
          final image = srcSet!.split(' ').first;
          print('srcSet: $image');

          _imgUrl = image!;

          // WebViewUrlScreen();

          notifyListeners();
          return true;

        } else {
          return false;
        }
      } else {
        // Handle other HTTP status codes
        print("HTTP Error: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      // Handle network errors
      print("Error fetching data: $e");
      return false;
    }
  }

  var logger = Logger();
  getDataFromWebcrateandbarrel(String Url) async {
    print(Url);
    Map<String, String> headers = {
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.93 Safari/537.36',
    };

    http.Response response = await http.get(Uri.parse(Url), headers: headers);
    // final document = parser.parse(response.body);
    logger.d(response.body.toString());
    // print("this is data${response.body.toString()}");
    dome.Document document = parser.parse(response.body.toString());
    var titleElement = document.querySelector('h1.product-name.text-xl-bold');

    // Extract the title text
    var title = titleElement!.text.trim();

    print("$title");
    var priceElement =
        document.querySelector('div.shop-bar-price-area.jsProductPrice');

    // Extract the price text
    var price = priceElement!.querySelector('.regPrice')!.text.trim();
    print("$price");

    var elements = document.getElementsByClassName('main-carousel-img-button');

    // Extract the data from each element
    var data = elements.map((element) {
      var imgElement = element.getElementsByTagName('img')[0];
      var alt = imgElement.attributes['alt'];
      var src = imgElement.attributes['src'];
      print(src);
      _imgUrl = src;
      return '$alt - $src';
    }).toList();
    _title = title;
    _price = price;
    // WebViewUrlScreen();
    notifyListeners();
  }

  getDataFromWebNeimanmarcus(String Url) async {
    print(Url);

    final response = await http.get(Uri.parse(Url));
    // final document = parser.parse(response.body);

    print("this is data${response.body.toString()}");
    dome.Document document = parser.parse(response.body.toString());
    var titleElement = document.querySelector('title');
    // if (titleElement != null) {
    var title = titleElement!.text;
    // Assuming the product name is separated by a delimiter, such as "|"
    var parts = title.split('|');
    if (parts.length > 0) {
      var productName = parts[0].trim();
      print(productName);
      _title = productName;
    }

    notifyListeners();
  }

  Future<void> fetchResponse(String text) async {
    final apiUrl =
        ''; // Replace with the actual API endpoint URL
    final apiKey =
        ''; // Replace with your actual API key

    print(text);

    Map<String, String> headerss = {
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (HTML, like Gecko) Chrome/96.0.4664.93 Safari/537.36',
    };

    final res = await http.get(Uri.parse(text), headers: headerss);
    // final document = parser.parse(response.body);

    print("this is data${res.body.toString().length}");

    final document = parser.parse(res.body);

    // Manipulate the DOM to remove header and footer
    final headerElement = document.querySelector('header');
    if (headerElement != null) {
      headerElement.remove();
    }

    final footerElement = document.querySelector('footer');
    if (footerElement != null) {
      footerElement.remove();
    }

    var data =
        document.outerHtml; // Updated HTML content without header and footer
    print("this remove content ${data}");
    print("this is my string length content ${data.length}");
    var chunks = data.substring(0, 10000);
    print("this is split result${chunks.length}");

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    final prompt =
        '''This is our html DOM\n${chunks}\n\nplease extract only product title, price, main image source of the product from this HTML DOM and please give precise answer in the below json format:
      Product Title: 
      Price: 
      Main Image Source: ''';

    // // final responses = <String>[];

    // for (final segment in textSegments) {
    final requestBody = jsonEncode({
      'messages': [
        {'role': 'user', 'content': prompt}
      ],
      'model': 'gpt-3.5-turbo',
      // "model": "text-davinci-003",
      'temperature': 1,
      'max_tokens': 200,
      'top_p': 1,
      'frequency_penalty': 0,
      'presence_penalty': 0,
    });

    final response =
        await http.post(Uri.parse(apiUrl), headers: headers, body: requestBody);
    print("this is URLLLL res${response.body}");

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final assistantResponse =
          responseData['choices'][0]['message']['content'];
      print("this is result of assistant$assistantResponse");

      var result = jsonDecode(assistantResponse);

      print('Title: ${result['Product Title']}');
      print('Price: ${result['Price']}');
      print('Image URL: ${result['Main Image Source']}');
      print('-----------');

      _title = result['Product Title'];
      _price = result['Price'];

      _imgUrl = result['Main Image Source'];
      notifyListeners();
      // }
    } else {
      // Handle errors
      print('API request failed with status code: ${response.statusCode}');
    }
  }

  getDataFromWebHannaandersson(String Url) async {
    print(Url);

    final response = await http.get(Uri.parse(Url));
    // final document = parser.parse(response.body);

    print("this is data${response.body.toString()}");
    dome.Document document = parser.parse(response.body.toString());

    final element = document.querySelector('.pdp-aplus__titleblock__name');
    print(element);
    // if (element != null) {
    print(element!.text);

    _title = element.text;

    final imgElement =
        document.querySelector('.js-image-zoom-0 > picture > img');
    print(imgElement);
    // if (imgElement != null) {
    final imageSrc = imgElement!.attributes['src'];
    print(imageSrc);

    _imgUrl = imageSrc;

    final salePriceElement =
        document.querySelector('.pdp-aplus__master-pricing__min');
    final salePrice = salePriceElement!.text.trim();
    // final priceelement = document.querySelector('.pdp-aplus__master-price');

    print(salePrice);
    _price = salePrice;

    notifyListeners();
  }

  getDataFromWebCb2(String url) async {
    // print(Url);s

    final response = await http.get(Uri.parse(url));
    // final document = parser.parse(response.body);

    print("this is  data${response.body.toString()}");
    logger.d(response.body.toString());
    dome.Document document = parser.parse(response.body.toString());

    final titleElement =
        document.querySelector('h1 < product-name.text-xl-bold');
    //  final titleElement = document.querySelector('.header-container h1.product-name');

    final saleElement = document.querySelector('.sale');

    if (saleElement != null) {
      final salePriceElement = saleElement.querySelector('.salePrice');
      final salePrice = salePriceElement?.text.trim() ?? '';
      print(salePrice);
    }
    // print(titleElement);
    if (titleElement != null) {
      final title = titleElement.text;
      print(title);
      // final price = salePriceElement!.text.trim();
      print(price);

      return title;
    }

    notifyListeners();
  }

  getDataFromWebCatBird(String Url) async {
    print(" this is urlllll$Url");

    final response = await http.get(Uri.parse(Url));
    // final document = parser.parse(response.body);

    print("this is data${response.body.toString()}");
    dome.Document document = parser.parse(response.body.toString());
    final titleElement =
        document.querySelector('.page-title-wrapper.product span.base');

    // if (titleElement != null) {
    final title = titleElement!.text;
    print(title);
    //   return title;
    // }
    _title = title!;

    final priceElement = document.querySelector('.price-container .price');

    // if (priceElement != null) {
    final price = priceElement!.text;
    print(price);
    _price = price!;

    final galleryItemElement = document.querySelector('.gallery-item');
    final imageUrl = galleryItemElement?.attributes['data-image'];
    print(imageUrl);

    _imgUrl = imageUrl!;

    print("this is data updated $_imgUrl......$_price.....$_title");

    notifyListeners();
  }

  Future<bool> getDataFromFreePeople(String Url) async {
    print(Url);

    final response = await http.get(Uri.parse(Url));
    // final document = parser.parse(response.body);

    // print("this is data${response.body.toString()}");
    dome.Document document = parser.parse(response.body.toString());

    final titleElement = document.querySelector('.c-pwa-product-meta-heading');

    var title = titleElement?.text.trim();
    if (title != null) {
      print(title);

      _title = title!;
      // return title;
      // }

      final priceElement =
          document.querySelector('.c-pwa-product-price__current');

      // if (priceElement != null) {
      final price = priceElement!.text.trim();
      print(price);
      _price = price!;
      // return price;
      // }

      final pictureElement =
          document.querySelector('.o-pwa-image.has-pwa-aspect-ratio');
      // if (pictureElement != null) {
      final imgElement = pictureElement!.getElementsByTagName('img').first;
      final srcset = imgElement.attributes['src'];
      var splidata = srcset!.split("wid").first;
      print('srcset: $srcset...$splidata');
      var imgurl = splidata! + "wid=800";

      _imgUrl = imgurl;
      // return src;
      // WebViewUrlScreen();

      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  getDataFromLuvEvery(String Url) async {
    print(Url);

    final response = await http.get(Uri.parse(Url));
    // final document = parser.parse(response.body);

    // print("this is data${response.body.toString()}");
    dome.Document document = parser.parse(response.body.toString());

    String? titleContent = document.head!
        .querySelector('meta[property="og:title"]')
        ?.attributes['content'];
    print('Title: $titleContent');

    _title = titleContent!;

    // String? priceAmountContent = document.head!
    //     .querySelector('meta[property="og:price:amount"]')
    //     ?.attributes['content'];
    // print('Price: $priceAmountContent');
    // _price = priceAmountContent!;

    // String? imageContent = document.head!
    //     .querySelector('meta[property="og:image"]')
    //     ?.attributes['content'];
    // print('Price: $imageContent');

    // _imgUrl = imageContent!;

    // if (imageContent == null || titleContent == null) {
      print("content null");

      // final titleElement = document.querySelector('.h2.product-info-header');
      // print(titleElement!.text.trim());

      // _title = titleElement!.text.trim();

      dome.Element? metaElement =
          document.querySelector('meta[property="og:image:secure_url"]');
      print(metaElement);

      final offersElement = document.querySelector('div[itemprop="offers"]');
      print(offersElement);
      // if (offersElement != null) {
      final priceMetaElement =
          offersElement!.querySelector('meta[itemprop="price"]');
      print(priceMetaElement);

      // if (priceMetaElement != null) {
      print(priceMetaElement!.attributes['content']);
      _price = "\$"+priceMetaElement!.attributes['content']!;

      // String? content = metaElement!.attributes['content'];
      // _imgUrl = content!;
      // print('Meta content: $content');

      // print('Meta element not found');

      // WebViewUrlScreen();

      notifyListeners();
    // }

    // WebViewUrlScreen();

    notifyListeners();
  }

  getDataFromRai(String Url) async {
    print(Url);
    final response = await http.get(Uri.parse(Url));
    // final document = parser.parse(response.body);

    // print("this is data${response.body.toString()}");
    dome.Document document = parser.parse(response.body.toString());

    String? title = document
        .querySelector('.product-title.product-header__product-title')
        ?.text;

    print('Title: $title');
    _title = title!;

    String? price = document.querySelector('#buy-box-product-price')?.text;

    print('Price: $price');
    _price = price!;

    dome.Element? imageElement = document.querySelector('.generic-media__img');
    String? src = imageElement?.attributes['src'];
    String imgUrl = "https://www.rei.com" + src!;
    print('Image Source URL: $imgUrl');
    _imgUrl = imgUrl;

    print("this is data $_imgUrl...$_price....$_title");
    if (_imgUrl != null) {
      // WebViewUrlScreen();
    }

    notifyListeners();
  }

  getDataFromShowCraftedByBeauty(String Url) async {
    print(Url);

    final response = await http.get(Uri.parse(Url));
    // final document = parser.parse(response.body);

    // print("this is data${response.body.toString()}");
    dome.Document document = parser.parse(response.body.toString());

    dome.Element? titleElement = document.querySelector('.product__title h1');
    String? title = titleElement?.text;

    print('Title: $title');

    _title = title!;

    dome.Element? priceElement = document.querySelector('.price-item--regular');
    String? price = priceElement?.text.trim();

    print('Price: $price');
    _price = price!;
    dome.Element? imgElement =
        document.querySelector('img.global-media-settings');
    String? srcSet = imgElement?.attributes['srcset'];
    String splitUrl = srcSet!.split(" ").first;
    String imgUrl = "https:" + splitUrl;

    print('srcset: $imgUrl');
    _imgUrl = imgUrl!;
    // WebViewUrlScreen();

    notifyListeners();
  }

  getDataFromShowWestElm(String Url) async {
    print(Url);

    final response = await http.get(Uri.parse(Url));

    dome.Document document = parser.parse(response.body.toString());

    dome.Element? titleElement = document.querySelector('h1.heading-title-pip');
    String? title = titleElement?.text;

    print('Title: $title');
    _title = title!;

    dome.Element? element =
        document.querySelector('img[data-test-id="thumbnail-widget-img-0"]');

    String? src = element?.attributes['data-srcset'];

    String imgUrl = src!.split(" ").first;
    print(imgUrl);

    _imgUrl = imgUrl!;

    // WebViewUrlScreen();
    notifyListeners();
  }

  getDataFromShowNordstrom(
      String url, String title, String price, String imgurl) async {
    _title = title;
    _price = price;
    _imgUrl = imgurl;

    print("this is our data $_imgUrl....$_price.....$_title");

    if (_title != "Title not found") {
      print(url.length);

      if (url.length > 130) {
        print(url.length);
        // WebViewUrlScreen();
        notifyListeners();
        return true;
      } else {
        return false;
      }
    }
    notifyListeners();
  }

  getDataNordStrom(String url) {
    print(url.length);
    if (url.length > 140) {
      // WebViewUrlScreen();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  getDataCB2(String url) {
    print(url.length);
    if (url.length > 100) {
      // WebViewUrlScreen();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  getDataAnthropologie(String url) {
    print(url.length);
    if (url.length > 100) {
      // WebViewUrlScreen();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getDataFromShowCaraWayHome(String Url) async {
    print(Url);

    final response = await http.get(Uri.parse(Url));

    print(Url.length);
    // final document = parser.parse(response.body);

    // print("this is data${response.body.toString()}");
    dome.Document document = parser.parse(response.body.toString());

    if (Url.length > 50) {
      final element = document.querySelector('.css-hpnsbd');
      final textContent = element?.text;
      print("data here $textContent");

      _title = textContent;

      print('data: $_title....$_price...$_imgUrl');

      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  getDataFromGlassBaby(String Url) async {
    print(Url);

    // final response = await http.get(Uri.parse(Url));
    // // final document = parser.parse(response.body);

    // // print("this is data${response.body.toString()}");
    // dome.Document document = parser.parse(response.body.toString());

    // final titleElement = document.querySelector('.ProductMeta__Title');
    // final priceElement = document.querySelector('.ProductMeta__Price');

    // final title = titleElement!.text;
    // final price = priceElement!.text;

    // final imgElement = document.querySelector('.Image--lazyLoad');

    // final srcsetAttribute = imgElement!.attributes['data-src'];

    // var splitdata = srcsetAttribute!.split("{width}").first;
    // var splitLastsite = srcsetAttribute!.split("{width}").last;

    // var imgUrl = splitdata + "1024" + splitLastsite;

    // print('Title: $title');
    // print('Price: $price');

    // print('https:$imgUrl');

    // _title = title;
    // _price = price;
    // _imgUrl = "https:" + imgUrl;
    // WebViewUrlScreen();

    notifyListeners();
  }

  Future getDataFromRhoBack(String Url) async {
    print(Url);

    final response = await http.get(Uri.parse(Url));
    // final document = parser.parse(response.body);

    // print("this is data${response.body.toString()}");
    dome.Document document = parser.parse(response.body.toString());

    final titleElement = document.querySelector('.product-single__title');
    final priceElement = document.querySelector('span.product__price');

    final title = titleElement!.text;
    final price = priceElement!.text;

    final imgElement = document.querySelector('.photoswipe__image');

    final srcsetAttribute = imgElement!.attributes['data-photoswipe-src'];

    print('Title: $title');
    print('Price: $price');

    print('data-srcset: https:$srcsetAttribute');

    _title = title;
    _price = price.trim();
    print(_price);
    _imgUrl = "https:" + srcsetAttribute!;
    // WebViewUrlScreen();

    notifyListeners();
  }

  void makeImageEmpty() {
    _imgUrl = "";
    notifyListeners();
  }

  getDataFromVolcom(String Url) async {
    print(Url);

    final response = await http.get(Uri.parse(Url));
    // final document = parser.parse(response.body);

    // print("this is data${response.body.toString()}");
    dome.Document document = parser.parse(response.body.toString());

    final titleElement = document.querySelector('.ProductHeading__title');

    final title = titleElement!.text.trim();

    final imageElement = document.querySelector('.ProductImages__image');
    final src = imageElement!.attributes['src'];
    print('Image Source: https:$src');

    print('Title: $title');
    // print('Price: $price');

    // print('data-srcset: https:$srcsetAttribute');

    _title = title;
    // _price = price;
    // print(_price);
    _imgUrl = "https:" + src!;
    // WebViewUrlScreen();

    notifyListeners();
  }

  getDataFromVuoriClothing(String Url) async {
    print(Url);

    final response = await http.get(Uri.parse(Url));
    // final document = parser.parse(response.body);

    // print("this is data${response.body.toString()}");
    dome.Document document = parser.parse(response.body.toString());

    final titleElement = document.querySelector('title');
    final priceElement = document.querySelector('span.price');
    final imageElement = document.querySelector('span.image_url');

    final title = titleElement!.text.trim();
    final price = priceElement!.text.trim();
    var imageUrl = imageElement?.text ?? '';

    print('Title: $title');
    print('Price: $price');

    print('data-srcset: https:$imageUrl');

    _title = title;
    _price = price;
    // print(_price);
    _imgUrl = "https:" + imageUrl!;
    // WebViewUrlScreen();

    notifyListeners();
  }

  getDataFromZoeChicco(String Url) async {
    print(Url);

    final response = await http.get(Uri.parse(Url));
    // final document = parser.parse(response.body);

    // print("this is data${response.body.toString()}");
    dome.Document document = parser.parse(response.body.toString());
    var titleElement = document.querySelector('h1.ProductMeta__Title');
    var priceElement = document.querySelector('span.ProductMeta__Price');

    // Extract the price from the element
    var price = priceElement?.text ?? '';

    // Extract the title from the element
    var title = titleElement?.text ?? '';

    final imgElement = document.querySelector('img.Image--fadeIn');

    if (imgElement != null) {
      final src = imgElement.attributes['data-src'];
      final dataWidths = imgElement.attributes['data-widths'];
      final dataSizes = imgElement.attributes['data-sizes'];
      final dataExpand = imgElement.attributes['data-expand'];
      final alt = imgElement.attributes['alt'];
      final maxWidth = imgElement.attributes['data-max-width'];
      final maxHeight = imgElement.attributes['data-max-height'];
      // _imgUrl = "https:" + src!;
      // notifyListeners();

      // Use the extracted data as needed
      print('src: $src');
      print('data-widths: $dataWidths');
      print('data-sizes: $dataSizes');
      print('data-expand: $dataExpand');
      print('alt: $alt');
      print('maxWidth: $maxWidth');
      print('maxHeight: $maxHeight');

      print('Title: $title');
      print('Price: $price');
    }
    final imgElements = document.querySelector('img');

    final src = imgElements!.attributes['src'];
    print('data-srcset: https:$src');

    _title = title;
    _price = price;
    // print(_price);
    // WebViewUrlScreen();

    notifyListeners();
  }

  getNeimanPriceData(String prices, String? imagec, String title) {
    print("thia ia prixce$prices........$imagec");
    _title = title;
    _price = prices!;

    if (imagec != null) {
  if (!imagec.startsWith("http:") && !imagec.startsWith("https:")) {
    _imgUrl = "https:" + imagec;
  } else {
    _imgUrl = imagec;
  }
}
    // _imgUrl = "https:" + imagec!;
    print("this is data $_imgUrl$_price");

    notifyListeners();
  }
   getbombasData(String prices, String? imagec, String title) {
    print("thia ia prixce$prices........$imagec");
    _title = title;
    _price = prices;

    // if (imagec != null) {
    //   if (!imagec.startsWith("https:")) {
    //     _imgUrl = "https:" + imagec;
    //   } else {
        _imgUrl = imagec;
    //   }
    // }
    // _imgUrl = "https:" + imagec!;
    print("this is data asas$_imgUrl$_price");

    notifyListeners();
  }

  getCokeWayPriceData(String prices, String? imageSrc, String title) {
    print("thia ia prixce$prices........$imageSrc");
    RegExp regExp = RegExp(r'\d+');
    Match? match = regExp.firstMatch(prices);

    // if (match != null) {
    String extractedDigits = match!.group(0)!;
    print(extractedDigits); // Output: 595
    // }

    _price = "\$" + extractedDigits;
    _title = title;
    if (imageSrc != "NODATA") {
      _imgUrl = imageSrc;
      print(_price);
      notifyListeners();
    } else {
      _imgUrl = "";
    }
    // WebViewUrlScreen();
    notifyListeners();
// return _price;
  }

  getPriceData(String prices, String? imageSrc) {
    print("thia ia prixce$prices........$imageSrc");
    RegExp regExp = RegExp(r'\d+');
    Match? match = regExp.firstMatch(prices);

    // if (match != null) {
    String extractedDigits = match!.group(0)!;
    print(extractedDigits); // Output: 595
    // }

    _price = "\$" + extractedDigits;
    if (imageSrc != "NODATA") {
      _imgUrl = imageSrc;
      print(_price);
    } else {
      _imgUrl = "";
    }

    notifyListeners();
// return _price;
  }

  getZoeChiccoImgeData(String img) {
    print("thia ia prixce$img......");
    _imgUrl = "https:" + img + " 1200w";

    notifyListeners();
    return _price;
  }

  getVolcomPriceData(String prices) {
    print("thia ia prixce$prices........$prices");
    _price = prices;
    print(_price);
    notifyListeners();
    return _price;
  }

  getWestElmPriceData(String prices) {
    print("thia ia prixce$prices........$prices");
    if (prices != null) {
      _price = prices;
      print(_price);
    } else {
      _price = "Some Price Not Scrap";
    }

    notifyListeners();
    return _price;
  }

  getZaraPriceData(String url, String prices, String title, String imgsrc) {
    print("thia ia prixce$prices........$title......$imgsrc");
    // if(url.length > 66){
    _price = prices;
    _imgUrl = imgsrc;
    _title = title;
    // print(_price);

    // WebViewUrlScreen();

    // }

    notifyListeners();
  }

  getAnthropogiePriceData(String prices, String title, String imgsrc) {
    print("thia ia prixce$prices........$title......$imgsrc");
    _price = prices;
    _imgUrl = imgsrc;
    _title = title;
    // print(_price);

    if (_title != null) {
      // WebViewUrlScreen();
    }
    notifyListeners();
  }

  getDataFromBombas(String Url) async {
    print(Url);

    final response = await http.get(Uri.parse(Url));
    // final document = parser.parse(response.body);

    // print("this is data${response.body.toString()}");
    dome.Document document = parser.parse(response.body.toString());
    final titleElement = document.querySelector('title');

    var title = titleElement?.text.trim() ?? '';

    final scriptTags = document.getElementsByTagName('script');

    for (var tag in scriptTags) {
      final scriptContent = tag.text;
      final priceRegExp = RegExp(r'"price":"([^"]+)"');
      final match = priceRegExp.firstMatch(scriptContent);

      if (match != null) {
        final price = match.group(1);

        // Use the extracted price as needed
        print('Price: $price');
        _price = price;
        notifyListeners();
        break;
      }
    }
    // print('Price: $price');
    print('Title: $title');

    var titleSplit = title.split("Bombas").first.trim();
    print(titleSplit.length);
    var titleSplit2 = titleSplit.split('\n')[0].trim();
    print("split title... $titleSplit2");
    _title = titleSplit2;
    // print(_title);

    _imgUrl = "";
// notifyListeners();

    // WebViewUrlScreen();

    notifyListeners();
  }

  getDataFromAmazon(String Url) async {
    print(Url);

    final response = await http.get(Uri.parse(Url));
    logger.d(response.body.toString());

    dome.Document document = parser.parse(response.body.toString());

    final jsonStartIndex = response.body.indexOf('{');
    final jsonEndIndex = response.body.lastIndexOf('}');

    if (jsonStartIndex >= 0 && jsonEndIndex > jsonStartIndex) {
      final jsonData =
          response.body.substring(jsonStartIndex, jsonEndIndex + 1);
      print(jsonData);
      final parsedData = json.decode(jsonData);
      if (parsedData.containsKey('turboHeaderText')) {
        print(parsedData['turboHeaderText']);
        return parsedData['turboHeaderText'];
      }
    }

    final titleElement = document.querySelector('.productTitle');
    final title = titleElement!.text.trim();

    print('Title: $title');
    // print('Price: $price');

    _title = title;
    _price = price;

    notifyListeners();
  }

///////Search Engine Function////
  Future performSearch(String query) async {
    final apiKey = 'YOUR_API_KEY';
    final searchEngineId = 'YOUR_SEARCH_ENGINE_ID';
    final url = 'https://www.googleapis.com/customsearch/v1?'
        'key=$apiKey&cx=$searchEngineId&q=$query';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey('items')) {
        _searchResults = List.from(data['items'])
            .map((item) => SearchResult.fromJson(item))
            .toList();
      }
    } else {
      // Handle API error
      print(
          'Search API request failed with status code: ${response.statusCode}');
    }
  }

////////////////////////
  getDataFromAnthropologie(String Url) async {
    print(Url);

    final response = await http.get(Uri.parse(Url));
    // final document = parser.parse(response.body);

    // print("this is data${response.body.toString()}");

    dome.Document document = parser.parse(response.body.toString());

    final titleElement = document.querySelector('title');
    final title = titleElement!.text.trim();
    final headingElement = document.querySelector(
        'c-pwa-product-info-heading-outer.js-pwa-product-info < c-pwa-product-meta-heading');
    final heading = headingElement!.text.trim();

    // Use the extracted heading as needed
    print('Heading: $heading');

    _title = title;
    _price = price;

    notifyListeners();
  }

  getDataFromZara(String Url) async {
    print(Url);
    print(Url.length);
    if (Url.length > 30) {
      // WebViewUrlScreen();
      // getAnthropogiePriceData(_price!,_title!,_imgUrl!);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  getDataFromTarget(String Url) async {
    print(Url);

    // Send a GET request to the website
    var response = await http.get(Uri.parse(Url));

    // Check if the request was successful
    var document = parser.parse(response.body);
    var titleElement = document.querySelector('h1[data-test="product-title"]');

    String title = titleElement!.text.trim();
    print("Title: $title");
    var elements = document.querySelectorAll('.h-text-md.h-text-grayDark');

    for (var element in elements) {
      String text = element.text.trim();
      _price = text;
      print("Text: $_price");
    }
    var elementss = document
        .querySelectorAll('.Heading__StyledHeading-sc-1ihrzmk-0.kjRCkj');

    for (var element in elementss) {
      String text = element.text.trim();
      _intrestPrice = text;
      print("Text: $_intrestPrice");
    }

    _title = title;

    var pictureElement = document
        .querySelector('picture.styles__FadeInPicture-sc-12vb1rw-0.gGbteH');

    // Extract the <img> element within the <picture> element
    var imgElement = pictureElement!.querySelector('img');

    String? src = imgElement!.attributes['src'];
    print("Image Src: $src");
    _imgUrl = src;
    // WebViewUrlScreen();
    notifyListeners();
  }

  WebViewScreen() {
    _title = "";
    _price = "";
    _imgUrl = "";
    _webViewScreenStatus = WebViewStatus.webView;
    notifyListeners();
  }
}
