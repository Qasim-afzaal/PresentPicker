import 'dart:convert';

ScrappingModel scrappingModelFromJson(String str) => ScrappingModel.fromJson(json.decode(str));

String scrappingModelToJson(ScrappingModel data) => json.encode(data.toJson());

enum PathType { local, network }

class ScrappingModel {
  ScrappingModel({
    required this.status,
    required this.data,
  });

  final bool status;
  final Data data;

  factory ScrappingModel.fromJson(Map<String, dynamic> json) => ScrappingModel(
        status: json["status"],
        data: Data.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };

  factory ScrappingModel.initial() => ScrappingModel(
        status: true,
        data: Data(
          title: "DEFAULT TITLE",
          mainImage: null,
          price: "300",
          currency: "USD",
          otherImages: [
            ImageType(
                path: "https://thumbs.dreamstime.com/b/shampoo-conditioner-bottles-blue-cap-white-background-96402933.jpg", type: PathType.network),
            ImageType(path: "https://m.media-amazon.com/images/I/71UPnhwu5iL._SL1500_.jpg", type: PathType.network),
            ImageType(path: "https://m.media-amazon.com/images/I/71xTYe-WBZL._SL1500_.jpg", type: PathType.network),
            ImageType(
                path:
                    "https://offautan-uc1.azureedge.net/-/media/images/off/ph/products-en/products-landing/landing/off_overtime_product_collections_large_2x.jpg",
                type: PathType.network),
            ImageType(path: "https://www.junglescout.com/wp-content/uploads/2021/01/product-photo-water-bottle-hero.png", type: PathType.network),
            ImageType(path: "https://png.pngitem.com/pimgs/s/49-498989_ok-hand-icon-circle-hand-emoji-png-transparent.png", type: PathType.network),
          ],
        ),
      );
}

class Data {
  Data({
    required this.title,
    required this.mainImage,
    required this.price,
    required this.currency,
    required this.otherImages,
  });

  final String? title;
  final String? mainImage;
  final String? price;
  final String? currency;
  final List<ImageType> otherImages;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        title: json["title"],
        mainImage: json["mainImage"],
        price: json["price"],
        currency: json["currency"],
        otherImages: List<ImageType>.from(
          json["otherImages"].map(
            (x) => ImageType(path: Uri.encodeFull(x), type: PathType.network),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "title": title ?? "",
        "mainImage": mainImage ?? "",
        "price": price ?? "",
        "currency": currency ?? "",
        "otherImages": List<dynamic>.from(otherImages.map((x) => x)),
      };
}

class ImageType {
  final String path;
  final PathType type;

  ImageType({
    required this.path,
    required this.type,
  });
}

// class GiftToAdd {
//   String? title;
//   String? uRL;
//   String? canonicalURL;
//   bool? currencyLock;
//   String? currencyDesc;
//   String? currencySymbol;
//   String? currencyId;
//   int? grabbedPrice;
//   String? readCurrency;
//   String? price;
//   String? singleImgUrl;
//   List<String>? images;
//
//   GiftToAdd(
//       {this.title,
//       this.uRL,
//       this.canonicalURL,
//       this.currencyLock,
//       this.currencyDesc,
//       this.currencySymbol,
//       this.currencyId,
//       this.grabbedPrice,
//       this.readCurrency,
//       this.price,
//       this.singleImgUrl,
//       this.images});
//
//   GiftToAdd.fromJson(Map<String, dynamic> json) {
//     title = json['Title'];
//     uRL = json['URL'];
//     canonicalURL = json['CanonicalURL'];
//     currencyLock = json['CurrencyLock'];
//     currencyDesc = json['CurrencyDesc'];
//     currencySymbol = json['CurrencySymbol'];
//     currencyId = json['CurrencyId'];
//     grabbedPrice = json['GrabbedPrice'];
//     readCurrency = json['ReadCurrency'];
//     price = json['Price'];
//     singleImgUrl = json['SingleImgUrl'];
//     if (json['Images'] != null) {
//       images = <String>[];
//       json['Images'].forEach((v) {
//         images!.add(v);
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['Title'] = title;
//     data['URL'] = uRL;
//     data['CanonicalURL'] = canonicalURL;
//     data['CurrencyLock'] = currencyLock;
//     data['CurrencyDesc'] = currencyDesc;
//     data['CurrencySymbol'] = currencySymbol;
//     data['CurrencyId'] = currencyId;
//     data['GrabbedPrice'] = grabbedPrice;
//     data['ReadCurrency'] = readCurrency;
//     data['Price'] = price;
//     data['SingleImgUrl'] = singleImgUrl;
//     if (images != null) {
//       data['Images'] = images!.map((v) => v).toList();
//     }
//     return data;
//   }
// }
