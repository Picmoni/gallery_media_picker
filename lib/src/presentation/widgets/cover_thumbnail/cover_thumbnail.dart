import 'package:flutter/material.dart';
// import 'package:gallery_media_picker/src/core/decode_image.dart';
import 'package:gallery_media_picker/src/core/functions.dart';
import 'package:gallery_media_picker/src/presentation/pages/gallery_media_picker_controller.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

class CoverThumbnail extends StatefulWidget {
  final int thumbnailQuality;
  final double thumbnailScale;
  final BoxFit thumbnailFit;
  const CoverThumbnail(
      {Key? key,
      this.thumbnailQuality = 120,
      this.thumbnailScale = 1.0,
      this.thumbnailFit = BoxFit.cover})
      : super(key: key);

  @override
  State<CoverThumbnail> createState() => _CoverThumbnailState();
}

class _CoverThumbnailState extends State<CoverThumbnail> {
  /// create object of PickerDataProvider
  final provider = GalleryMediaPickerController();

  @override
  void initState() {
    GalleryFunctions.getPermission(setState, provider);
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      provider.pickedFile.clear();
      provider.picked.clear();
      provider.pathList.clear();
      PhotoManager.stopChangeNotify();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return provider.pathList.isNotEmpty
        ? AssetEntityImage(
            provider.picked[0],
            isOriginal: false,
            thumbnailFormat: ThumbnailFormat.jpeg,
            filterQuality: FilterQuality.none,
            fit: BoxFit.cover,
          )
        // Image(
        //     image: AssetEntityImageProvider(
        //       provider.picked[0],
        //       isOriginal: false,
        //       thumbnailSize: const ThumbnailSize.square(120),
        //       thumbnailFormat: ThumbnailFormat.jpeg,
        //     ),

        //     // image: DecodeImage(provider.pathList[0],
        //     //     thumbSize: widget.thumbnailQuality,
        //     //     index: 0,
        //     //     scale: widget.thumbnailScale),
        //     fit: widget.thumbnailFit,
        //     filterQuality: FilterQuality.high,
        //   )
        : Container();
  }
}
