import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as sky;
import 'dart:async';
import 'dart:typed_data';
import 'package:mojo/core.dart' as core;

main() async {
  final double width = 300.0;
  final double height = 300.0;
  final ColorFilter colorFilter =
   new ColorFilter.mode(new Color.fromARGB(0xaa, 0xff, 0xaa, 0xaa), TransferMode.color);
  //final ImageFit fit = ImageFit.fill;
  //final ImageRepeat repeat = ImageRepeat.repeat;
  //final Rect centerSlice = new Rect.fromLTWH(0.0, 0.0, 20.0, 20.0);

  //
  // icom.jpeg is error 2015 12/03
  //ByteData data = await ResourceLoader.load("assets/icon.jpeg");
  ByteData data = await ResourceLoader.load("assets/a.png");


  RawImage i = new RawImage(
    image:await decodeImageFromList(data.buffer.asUint8List()),
    //bytes:data.buffer.asUint8List(),
    width:width,height:height,
    colorFilter:colorFilter);
  runApp(new Center(child:i));
}


class ResourceLoader {
  static AssetBundle getAssetBundle() {
    if (rootBundle != null) {
      return rootBundle;
    } else {
      return new NetworkAssetBundle(new Uri.directory(Uri.base.origin));
    }
  }

  static Future<ByteData> load(String url) async {
    AssetBundle bundle = getAssetBundle();
    core.MojoDataPipeConsumer c = await bundle.load(url);
    return await core.DataPipeDrainer.drainHandle(c);
  }
}
