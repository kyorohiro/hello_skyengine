import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as sky;
import 'dart:math' as math;
import 'dart:async';

main() async {
  BoxConstraints constraints = new BoxConstraints();
  BoxDecoration decoration = createDecoration();
  //BoxDecoration foregroundDecoration = createForegroundDecoration();
  EdgeDims margin = new EdgeDims.symmetric(vertical: 1.0, horizontal: 3.0);
  EdgeDims padding = new EdgeDims.symmetric(vertical: 4.0, horizontal: 5.0);
  Matrix4 transform =
  new Matrix4.translationValues(150.0, 150.0, 0.0)
  ..rotateZ(math.PI/180*30.0)
  ..translate(-150.0,-150.0,0.0);
  double width = 300.0;
  double height = 300.0;
  Container c = new Container(
    child:new Text("Hello!!"),
    constraints:constraints,
    decoration:decoration,
    //foregroundDecoration:foregroundDecoration,
    margin:margin,
    padding:padding,
    transform:transform,
    width:width,
    height:height
  );
  runApp(new Center(child:c));
}

BoxDecoration createDecoration() {
  Color backgroundColor = new Color.fromARGB(0xaa, 0xff, 0xaa, 0xaa);
  BackgroundImage backgroundImage = createBackgroundImage();
  Border border = new Border.all(color:new Color.fromARGB(0xff, 0xff, 0x00, 0x00));
  double borderRadius = 10.0;
  List<BoxShadow> boxShadow;
  Gradient gradient;
  Shape shape;
  return new BoxDecoration(
    backgroundColor:backgroundColor,
    backgroundImage:backgroundImage,
    border:border,
    borderRadius:borderRadius);
}

BackgroundImage createBackgroundImage() {
  ImageResource image =  new ImageResource(ImageLoader.load("icon.jpeg"));
  ImageFit fit = ImageFit.none;
  //ImageRepeat repeat = ImageRepeat.repeat;
  Rect centerSlice = new Rect.fromLTWH(10.0, 10.0, 100.0, 100.0);
  sky.ColorFilter colorFilter = new sky.ColorFilter.mode(
      new Color.fromARGB(0xaa, 0xff, 0xaa, 0xaa), TransferMode.lighten);
  return new BackgroundImage(
    image:image,
    fit:fit,
    //repeat:repeat,
    colorFilter:colorFilter,
    centerSlice:centerSlice
    );
}

class ImageLoader {
  static Future<sky.Image> load(String url) async {
    UrlResponse response = await fetchUrl(url);
      if(response.body == null) {
      throw "failed load ${url}";
    } else {
      Completer<sky.Image> completer = new Completer();
      sky.decodeImageFromDataPipe(
          response.body.handle.h, completer.complete);
      return completer.future;
    }
  }
}
