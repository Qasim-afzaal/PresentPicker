import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:present_picker/model/scrapping_model.dart';


class MoreImagesView extends StatefulWidget {
  static const String id = "/more-images-view";
  final List<ImageType> moreImages;
  const MoreImagesView({Key? key, required this.moreImages}) : super(key: key);

  @override
  State<MoreImagesView> createState() => _MoreImagesViewState();
}

class _MoreImagesViewState extends State<MoreImagesView> {
  XFile? file;
  ImageType? selectedImage;

  double getBorderSize(ImageType currentImage) {
    if (selectedImage == null) {
      return 1;
    } else {
      if (selectedImage!.path == currentImage.path) {
        return 2.5;
      } else {
        return 1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (selectedImage != null) {
          Navigator.pop(context, selectedImage);
          return true;
        } else {
          return true;
        }
      },
      child: SizedBox(
        height: 8,
        //height: MediaQuery.of(context).size.height * 0.5,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1),
          itemCount: widget.moreImages.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedImage = widget.moreImages[index];
                });
              },
              child: Container(
                width: 180,
                height: 180,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff919191), width: getBorderSize(widget.moreImages[index])),
                ),
                child: widget.moreImages[index].type == PathType.network
                    ? Image.network(
                        fit: BoxFit.cover,
                        widget.moreImages[index].path,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.warning_rounded),
                      )
                    : Image.file(
                        File(widget.moreImages[index].path),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.warning_rounded),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
