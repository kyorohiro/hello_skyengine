import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as sky;
import 'dart:async';
import 'dart:typed_data';
import 'package:vector_math/vector_math_64.dart';
import 'package:flutter/services.dart';

sky.Image img = null;
main() async {
  // "assets/icon.jpeg" is error 2015/12/13 's flutter, when draw image
  img = await ImageLoader.load("assets/a.png");
  sky.TileMode tmx = sky.TileMode.clamp;
  sky.TileMode tmy = sky.TileMode.clamp;
  Float64List matrix4 = new Matrix4.identity().storage;

   new sky.ImageShader(img, tmx, tmy, matrix4);
}

class ImageLoader {
  static AssetBundle getAssetBundle() {
    if (rootBundle != null) {
      return rootBundle;
    } else {
      return new NetworkAssetBundle(new Uri.directory(Uri.base.origin));
    }
  }
  static Future<sky.Image> load(String url) async {
    AssetBundle bundle = getAssetBundle();
    ImageResource resource = bundle.loadImage(url);
    return resource.first;
  }
}
