Gallery Photo Picker is based in [photo_widget](https://pub.dev/packages/photo_widget) package and has the same concept as image_picker but with a more attractive interface to choose an image or video from the device gallery, whether it is Android or iOS.

## Features

[✔] pick image

[✔] pick video

[✔] pick multi image / video

[x] take picture or video from camera

## Demo (custom view)
<img src="https://github.com/camilo1498/gallery_media_picker/blob/master/screenshots/demo_custom_view.gif" width="250" height=450"/>

## Demo (preset view)
![preset view](https://github.com/camilo1498/gallery_media_picker/blob/master/screenshots/demo_preset_view.gif)

## Installation
1) This package has only tested in android, add `gallery_media_picker: 0.0.4` in your `pubspec.yaml`
2) import `gallery_media_picker`
```dart
import 'package:gallery_media_picker/gallery_media_picker.dart';
```

## Getting started

1) update kotlin version to `1.6.0` and `classpath 'com.android.tools.build:gradle:7.0.4'` in your `build.gradle`
2) in `android` set the `minSdkVersion` to `25` in your `build.gradle`
3) add uses-permission `AndroidMAnifest.xml` file
```xml
 <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
```

## How to use
Create a `GalleryMediaPicker()` widget:
```dart
Material(
    child: GalleryMediaPicker(
        /// required params
        pathList: (List<Map<String,dynamic>> path) {}, /// => (type List<Map<String,dynamic>>) return a list map with selected media metadata
        /// optional params
        maxPickImages: , /// (type int)
        singlePick: , /// (type bool)
        appBarColor: , /// (type Color)
        albumBackGroundColor: , /// (type Color)
        albumDividerColor: , /// (type Color)
        albumTextColor: , /// (type Color)
        appBarIconColor, /// (type Color)
        appBarTextColor: , /// (type Color)
        crossAxisCount, /// /// (type int)
        gridViewBackgroundColor: , /// (type Color)
        childAspectRatio, /// (type double)
        appBarLeadingWidget, /// (type Widget)
        appBarHeight: , /// (type double)
        imageBackgroundColor: , /// (type Color)
        gridPadding: /// (type EdgeInset)
        gridViewControlle:, /// (type ScrollController)
        gridViewPhysics: /// (type ScrollPhysics)
        selectedBackgroundColor: /// (type Color)
        selectedCheckColor: , /// (type Color)
        thumbnailBoxFix: , /// (type BoxFit)
        selectedCheckBackgroundColor: , /// (type Color)
        onlyImages: , /// (type bool)
        onlyVideos: , /// (type bool)
        )
    );
```

## Example
```dart
import 'package:flutter/material.dart';
import 'package:gallery_media_picker/gallery_media_picker.dart';

void main() => runApp(const Example());

class Example extends StatelessWidget {
  const Example({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: GalleryMediaPicker(
            pathList: (pathList){}
        ),
      ),
    );
  }
}

```
