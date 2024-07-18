// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    required this.status,
    required this.data,
  });

  final bool status;
  final Data data;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.token,
    required this.user,
  });

  final String token;
  final User user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
      };
}

class User {
  User({
    required this.notification,
    required this.emailVerified,
    required this.phoneVerified,
    required this.version,
    required this.id,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.favorites,
    required this.gender,
    required this.avatar,
    required this.phone,
    required this.originalId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final Notification notification;
  final bool emailVerified;
  final bool phoneVerified;
  final String version;
  final String id;
  final String email;
  final String firstname;
  final String lastname;
  final String username;
  final Favorites favorites;
  final String gender;
  final String avatar;
  final String phone;
  final String originalId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  factory User.fromJson(Map<String, dynamic> json) => User(
        notification: Notification.fromJson(json["notification"]),
        emailVerified: json["email_verified"],
        phoneVerified: json["phone_verified"],
        version: json["version"],
        id: json["_id"],
        email: json["email"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        username: json["username"],
        favorites: Favorites.fromJson(json["favorites"]),
        gender: json["gender"],
        avatar: json["avatar"],
        phone: json["phone"],
        originalId: json["originalId"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "notification": notification.toJson(),
        "email_verified": emailVerified,
        "phone_verified": phoneVerified,
        "version": version,
        "_id": id,
        "email": email,
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "favorites": favorites.toJson(),
        "gender": gender,
        "avatar": avatar,
        "phone": phone,
        "originalId": originalId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Favorites {
  Favorites({
    required this.store,
    required this.thing,
    required this.drink,
    required this.snack,
  });

  final String store;
  final String thing;
  final String drink;
  final String snack;

  factory Favorites.fromJson(Map<String, dynamic> json) => Favorites(
        store: json["store"],
        thing: json["thing"],
        drink: json["drink"],
        snack: json["snack"],
      );

  Map<String, dynamic> toJson() => {
        "store": store,
        "thing": thing,
        "drink": drink,
        "snack": snack,
      };
}

class Notification {
  Notification({
    required this.email,
    required this.seasonal,
    required this.newFeature,
    required this.text,
    required this.unsubscribed,
  });

  final bool email;
  final bool seasonal;
  final bool newFeature;
  final bool text;
  final bool unsubscribed;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        email: json["email"],
        seasonal: json["seasonal"],
        newFeature: json["new_feature"],
        text: json["text"],
        unsubscribed: json["unsubscribed"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "seasonal": seasonal,
        "new_feature": newFeature,
        "text": text,
        "unsubscribed": unsubscribed,
      };
}
