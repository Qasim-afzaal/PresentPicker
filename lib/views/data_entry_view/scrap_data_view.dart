import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:present_picker/service/wishlist_service.dart';
import 'package:present_picker/views/auth/email_view.dart';
import 'package:present_picker/views/data_entry_view/more_images_view.dart';
import 'package:present_picker/views/home/home_view.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../model/scrapping_model.dart';
import '../../model/wishlist_model.dart';
import '../../service/app_service.dart';
import '../../utils/Utils.dart';

class ScrapDataView extends StatefulWidget {
  final String url;
  static const String id = "/scrap-view";

  const ScrapDataView({required this.url, Key? key}) : super(key: key);

  @override
  State<ScrapDataView> createState() => _ScrapDataViewState();
}

class _ScrapDataViewState extends State<ScrapDataView> {
  bool isLoading = false;
  String response = '';
  bool checkBoxValue = false;
  bool isDataEntered = false;
  ImageType? selectedImage;
  bool isVisible = false;
  bool _isBool = false;
  final AppService appService = AppService();
  final WishListService wishListService = WishListService();
  ImagePicker imagePicker = ImagePicker();
  XFile? imagePicked;
  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();

  WishList createWishListModel(ScrappingModel model) {
    if (selectedImage == null) {
      return WishList(
        favorite: checkBoxValue.toString(),
        name: _titleController.text,
        price: _priceController.text,
        thumbnail: model.data.mainImage,
        size: _sizeController.text,
        colorFlavor: _colorController.text,
        quantity: _quantityController.text,
        website: widget.url,
      );
    } else {
      if (selectedImage!.type == PathType.network) {
        return WishList(
          favorite: checkBoxValue.toString(),
          name: _titleController.text,
          price: _priceController.text,
          thumbnail: selectedImage!.path,
          size: _sizeController.text,
          colorFlavor: _colorController.text,
          quantity: _quantityController.text,
          website: widget.url,
        );
      } else {
        return WishList(
          favorite: checkBoxValue.toString(),
          name: _titleController.text,
          price: _priceController.text,
          thumbnail: "",
          file: selectedImage!.path,
          size: _sizeController.text,
          colorFlavor: _colorController.text,
          quantity: _quantityController.text,
          website: widget.url,
        );
      }
    }
  }

  List<ImageType> image = [];

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: FutureBuilder<ScrappingModel>(
        future: appService.scrapDataFromUrl(widget.url),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ScrappingModel model = snapshot.data!;
            if (!isDataEntered) {
              _titleController.text = model.data.title ?? "";
              _colorController.text = "";
              _quantityController.text = "";
              _priceController.text = model.data.price ?? "";
              _sizeController.text = "";
            }
            isDataEntered = true;
            return Scaffold(
              body: OrientationBuilder(
                builder: (context, orientation) {
                  return ListView(
                    padding: orientation == Orientation.landscape
                        ? const EdgeInsets.symmetric(horizontal: 128)
                        : const EdgeInsets.symmetric(horizontal: 0),
                    children: [
                      Container(height: screenHeight * 0.05),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, HomeView.id);
                            },
                            icon: const Icon(Icons.close)),
                      ),
                      orientation == Orientation.landscape ? SizedBox(height: screenHeight * 0.05) : SizedBox(height: screenHeight * 0.015),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Column(
                          children: [
                            const H2(text: 'Add To Present Picker\nWish list'),
                            Container(
                              height: 200,
                              margin: const EdgeInsets.only(top: 20),
                              width: double.infinity,
                              decoration: BoxDecoration(border: Border.all()),
                              child: (!_isBool)
                                  ? Image.network(
                                      model.data.mainImage == null
                                          ? model.data.otherImages.isNotEmpty
                                              ? model.data.otherImages[0].path
                                              : ''
                                          : model.data.mainImage!,
                                      height: 200,
                                      width: 200,
                                      errorBuilder: (context, error, stackTrace) => GestureDetector(
                                          onTap: () async {
                                            imagePicked = await imagePicker.pickImage(source: ImageSource.gallery);
                                            setState(() {
                                              _isBool = !_isBool;
                                            });
                                          },
                                          child: const Icon(Icons.add)),
                                    )
                                  : imagePicked == null
                                      ? GestureDetector(
                                          onTap: () async {
                                            imagePicked = await imagePicker.pickImage(source: ImageSource.gallery);
                                            setState(() {
                                              _isBool = !_isBool;
                                            });
                                          },
                                          child: const Icon(Icons.add))
                                      : Image.file(File(imagePicked!.path)),
                            ),
                            GestureDetector(
                              onTap: () async {
                                setState(() {
                                  isVisible = !isVisible;
                                  if (!isVisible) {
                                    image = List.from(model.data.otherImages);
                                    image.add(ImageType(path: model.data.mainImage ?? "", type: PathType.network));
                                  }
                                });
                              },
                              child: (model.data.otherImages.isNotEmpty)
                                  ? Padding(
                                      padding: const EdgeInsets.only(bottom: 30),
                                      child: Text((!isVisible) ? 'Show More Images' : 'Hide Images', style: Utils.b3TextStyleWithUnderLine),
                                    )
                                  : const SizedBox(),
                            ),
                            (isVisible) ? MoreImagesView(moreImages: image) : const SizedBox(),
                            SizedBox(
                              child: TextFieldLabel(text: '*Name of item'),
                            ),
                            Form(
                              key: formKey,
                              child: TextFormField(
                                decoration: const UiField(),
                                controller: _titleController,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "Name of Item is required";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: LabelTextField(label: "Price", controller: _priceController),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: LabelTextField(controller: _sizeController, label: "Size"),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: LabelTextField(
                                      controller: _quantityController,
                                      label: "Quantity",
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(child: SizedBox(width: 80, child: LabelTextField(label: 'Color/Type', controller: _colorController))),
                                  const SizedBox(width: 4),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 10),
                                      width: 100,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 10,
                                            child: Checkbox(
                                                value: checkBoxValue,
                                                side: const BorderSide(width: 1, color: Color(0xff919191)),
                                                activeColor: Colors.black,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    checkBoxValue = newValue!;
                                                  });
                                                }),
                                          ),
                                          const SizedBox(width: 60, child: Align(alignment: Alignment.centerLeft, child: P2(text: 'Favorite'))),
                                          const SizedBox(width: 8),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: B1(
                                title: !isLoading ? 'ADD TO WISH LIST' : 'ADDING TO WISH LIST',
                                onPressed: !isLoading
                                    ? () async {
                                        if (formKey.currentState?.validate() ?? false) {
                                          WishList wishListData = createWishListModel(model);
                                          bool isFile = wishListData.file != null;
                                          setState(() {
                                            isLoading = true;
                                          });
                                          try {
                                            await wishListService.postWishList(wishList: wishListData, isFile: isFile);
                                            setState(() => isLoading = false);
                                            showModalBottomSheet(
                                              isDismissible: false,
                                              isScrollControlled: true,
                                              context: context,
                                              builder: (context) => WishListSavingSuccessful(
                                                otherImages: model.data.otherImages,
                                                onPressed: () {
                                                  Navigator.popUntil(context, (route) => route.settings.name == "HomeView");
                                                },
                                              ),
                                            );
                                          } catch (e) {
                                            setState(() => isLoading = false);
                                            showModalBottomSheet(
                                              isScrollControlled: true,
                                              context: context,
                                              builder: (context) => const ErrorSavingWishList(),
                                            );
                                          }
                                        }
                                      }
                                    : null,
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }

          if (snapshot.hasError) {
            return const Scaffold(body: Center(child: Text("GETTING DATA FAILED")));
          }

          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}

class LabelTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;

  const LabelTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(alignment: Alignment.centerLeft, child: P2(text: label)),
        TextFormField(
          textAlign: TextAlign.left,
          decoration: const UiField(),
          controller: controller,
          inputFormatters: inputFormatters,
        ),
      ],
    );
  }
}

class SavingWishList extends StatelessWidget {
  const SavingWishList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: Wrap(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: H2(text: 'Saving.....'),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Center(
                  child: P1(text: 'This item is getting added to your wish list\non Present Picker'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorSavingWishList extends StatelessWidget {
  const ErrorSavingWishList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: Wrap(
          children: [
            Center(
              child: H2(text: 'Error Saving'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Center(
                child: P1(text: 'Error occurs while saving your item\non Present Picker'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WishListSavingSuccessful extends StatelessWidget {
  WishListSavingSuccessful({super.key, required this.onPressed, required this.otherImages});

  final Function() onPressed;
  final List<ImageType> otherImages;
  final WishListService wishListService = WishListService();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Wrap(
          children: [
            Container(height: 30),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, HomeView.id);
                },
                icon: const Icon(Icons.close),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  Container(height: screenHeight * 0.13),
                  Center(
                    child:
                        otherImages.isEmpty ? Image.asset('assets/images/giftbox.png', height: 180, width: 160) : Image.network(otherImages[0].path),
                  ),
                  const SizedBox(height: 24),
                  const Center(child: H2(text: 'Added To Your Wish List')),
                  const SizedBox(height: 10),
                  const Center(
                    child: P1(
                      text:
                          'This item has been added to your wish list on Present Picker, Select add preferences to add sizes, color, favorite or quantity.',
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 70, right: 70),
                    child: B1(
                        title: 'VIEW WISH LIST',
                        onPressed: () {
                          _launchURL();
                        }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _launchURL() async {
    const url = 'https://www.presentPicker.com/wish-list';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class LoginBottomSheet extends StatelessWidget {
  const LoginBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => Navigator.pushNamed(context, HomeView.id),
                icon: const Icon(Icons.close),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.35),
            const Center(
              child: H2(text: 'Oops, you need to login\nfor that'),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Center(
                child: P1(text: 'In order to use that feature, you need to log in or\ncreate an account'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 70, right: 70),
              child: B1(
                title: 'LOGIN',
                onPressed: () => Navigator.pushNamed(context, EmailView.id, arguments: EmailViewArguments(emailViewType: EmailViewType.scraping)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
