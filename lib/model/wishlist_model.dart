class WishList {
  String? favorite;
  String? purchased;
  String? received;
  String? name;
  String? website;
  String? retailer;
  String? price;
  String? size;
  String? quantity;
  String? colorFlavor;
  String? description;
  String? thumbnail;
  String? file;

  WishList({
    this.favorite,
    this.purchased,
    this.received,
    this.name,
    this.website,
    this.retailer,
    this.price,
    this.size,
    this.quantity,
    this.colorFlavor,
    this.description,
    this.thumbnail,
    this.file,
  });

  WishList.fromJson(Map<String, dynamic> json) {
    favorite = json['favorite'];
    purchased = json['purchased'];
    received = json['received'];
    name = json['name'];
    website = json['website'];
    retailer = json['retailer'];
    price = json['price'];
    size = json['size'];
    quantity = json['quantity'];
    colorFlavor = json['color_flavor'];
    description = json['description'];
    thumbnail = json['thumbnail'];
  }

  Map<String, String> toJsonWithThumbnail() {
    final Map<String, String> data = <String, String>{};
    data['name'] = name ?? "";
    data['website'] = website ?? "";
    data['retailer'] = retailer ?? "";
    data['price'] = price ?? "0";
    data['size'] = size ?? "0";
    data['quantity'] = quantity ?? "0";
    data['color_flavor'] = colorFlavor ?? "0";
    data['favorite'] = favorite ?? "false";
    data['description'] = description ?? "";
    data['thumbnail'] = thumbnail ?? "";
    data['received'] = received ?? "false";
    data['purchased'] = purchased ?? "false";
    return data;
  }

  Map<String, String> toJsonWithFile() {
    final Map<String, String> data = <String, String>{};
    data['name'] = name ?? "";
    data['website'] = website ?? "";
    data['retailer'] = retailer ?? "";
    data['price'] = price ?? "0";
    data['size'] = size ?? "0";
    data['quantity'] = quantity ?? "0";
    data['color_flavor'] = colorFlavor ?? "0";
    data['favorite'] = favorite ?? "false";
    data['description'] = description ?? "";
    data['received'] = received ?? "false";
    data['purchased'] = purchased ?? "false";
    data["file"] = file ?? "";
    return data;
  }
}
