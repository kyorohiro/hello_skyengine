# Dart:UI Draw

https://github.com/kyorohiro/hello_skyengine/tree/master/dartui_draw

![](screen.png)

```
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:vector_math/vector_math_64.dart';

// ex 3:4 game screen
double stageWidth = 800.0;
double stageHeight = 600.0;
ui.Rect stageSize = new ui.Rect.fromLTWH(0.0, 0.0, stageWidth, stageHeight);

ui.Scene createScene(ui.Picture picture) {
  double widthPaddingless  = ui.view.width-ui.view.paddingLeft-ui.view.paddingRight;
  double heightPaddingless = ui.view.height-ui.view.paddingTop-ui.view.paddingBottom;
  double rw = widthPaddingless/stageWidth;
  double rh = heightPaddingless/stageHeight;
  double stageRatio = (rw<rh?rw:rh);
  double t = ui.view.paddingTop;
  double l = ui.view.paddingLeft + (widthPaddingless-stageWidth*stageRatio)/2.0;

  ui.Rect sceneBounds = new ui.Rect.fromLTWH(
    0.0, 0.0,
    ui.view.width * ui.view.devicePixelRatio,
    ui.view.height * ui.view.devicePixelRatio
  );

  Matrix4 mat = new Matrix4.identity();
  mat.translate(l*ui.view.devicePixelRatio, t*ui.view.devicePixelRatio);
  mat.scale(stageRatio*ui.view.devicePixelRatio, stageRatio*ui.view.devicePixelRatio, 1.0);

  ui.SceneBuilder sceneBuilder = new ui.SceneBuilder(sceneBounds);
  sceneBuilder.pushTransform(mat.storage);
  sceneBuilder.pushClipRect(stageSize);
  sceneBuilder.addPicture(ui.Offset.zero, picture, stageSize);
  sceneBuilder.pop();
  sceneBuilder.pop();
  return sceneBuilder.build();
}

void onPaint(double timeStamp) {
  print("---onPaint ${timeStamp}");
  //
  ui.PictureRecorder recorder = new ui.PictureRecorder();
  ui.Canvas canvas = new ui.Canvas(recorder, stageSize);

  //
  ui.Paint paint = new ui.Paint();
  paint.strokeWidth = 30.0;
  paint.style = ui.PaintingStyle.stroke;
  paint.color = new ui.Color.fromARGB(0xff, 0xff, 0xaa, 0x77);
  ui.Rect drawRectSize = new ui.Rect.fromLTWH(
    paint.strokeWidth, paint.strokeWidth,
    stageWidth-paint.strokeWidth*2,
    stageHeight-paint.strokeWidth*2);
  canvas.drawRect(drawRectSize, paint);
  ui.Picture picture = recorder.endRecording();

  ui.view.scene = createScene(picture);
}

void main() {
  ui.view.setFrameCallback(onPaint);
  ui.view.setMetricsChangedCallback((){
      ui.view.scheduleFrame();
  });
  ui.view.scheduleFrame();
}
```
