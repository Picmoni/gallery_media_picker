import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gallery_media_picker/src/presentation/pages/gallery_media_picker_controller.dart';
import 'package:gallery_media_picker/src/presentation/widgets/select_album_path/dropdown.dart';
import 'package:gallery_media_picker/src/presentation/widgets/select_album_path/overlay_drop_down.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryFunctions {
  static FeatureController<T> showDropDown<T>({
    required BuildContext context,
    required DropdownWidgetBuilder<T> builder,
    double? height,
    Duration animationDuration = const Duration(milliseconds: 250),
    required TickerProvider tickerProvider,
  }) {
    final animationController = AnimationController(
      vsync: tickerProvider,
      duration: animationDuration,
    );
    final completer = Completer<T?>();
    var isReply = false;
    OverlayEntry? entry;
    void close(T? value) async {
      if (isReply) {
        return;
      }
      isReply = true;
      animationController.animateTo(0).whenCompleteOrCancel(() async {
        await Future.delayed(const Duration(milliseconds: 16));
        completer.complete(value);
        entry?.remove();
      });
    }

    /// overlay widget
    entry = OverlayEntry(
        builder: (context) => GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => close(null),
              child: OverlayDropDown(
                  height: height!,
                  close: close,
                  animationController: animationController,
                  builder: builder),
            ));
    Overlay.of(context).insert(entry);
    animationController.animateTo(1);
    return FeatureController(
      completer,
      close,
    );
  }

  static getPermission(setState, GalleryMediaPickerController provider) async {
    // Request permissions.
    final PermissionState ps = await PhotoManager.requestPermissionExtend();

    // Further requests can be only proceed with authorized or limited.
    if (!ps.hasAccess) {
      PhotoManager.openSetting();
    }
    // Obtain assets using the path entity.
    final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
      onlyAll: true,
      filterOption: FilterOptionGroup(
        imageOption: const FilterOption(
          sizeConstraint: SizeConstraint(ignoreSize: true),
        ),
      ),
    );

    // continue if paths found.
    if (paths.isNotEmpty) {
      // get the first path entity.
      final AssetPathEntity path = paths.first;
      // get all assets contained in path entity.
      provider.assetCountNotifier.value = await path.assetCountAsync;

      final List<AssetEntity> assets = await path.getAssetListPaged(
        page: 0,
        size: 50,
      );

      setState(() {
        provider.resetPathList(paths);
        provider.picked = assets;
      });
    }
  }

  // static _refreshPathList(setState, GalleryMediaPickerController provider) {
  //   PhotoManager.getAssetPathList(type: RequestType.common).then((pathList) {
  //     /// don't delete setState
  //     Future.delayed(Duration.zero, () {
  //       setState(() {
  //         provider.resetPathList(pathList);
  //       });
  //     });
  //   });
  // }

  /// get asset path
  static Future getFile(AssetEntity asset) async {
    var file = await asset.file;
    return file!.path;
  }
}

class FeatureController<T> {
  final Completer<T?> completer;

  final ValueSetter<T?> close;

  FeatureController(this.completer, this.close);

  Future<T?> get closed => completer.future;
}
