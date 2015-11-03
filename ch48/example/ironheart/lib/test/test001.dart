import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:ch48/tinygame.dart';
import 'package:ch48/tinygame_flutter.dart';
import '../glogic/glogic.dart';

TinyGameRoot root;
TinyGameBuilderForFlutter builder;
TinyStage stage;
void main() {
  builder = new TinyGameBuilderForFlutter();
  runApp(new GameWidget());
}

class GameWidget extends OneChildRenderObjectWidget {
  GameWidget() {}
  RenderObject createRenderObject() {
    root = new TinyGameRoot(800.0, 600.0);
    stage = builder.createStage(root);
    stage.start();
    TinyScrollView scroll = new TinyScrollView(400.0, 400.0, 1050.0, 1050.0);
    scroll.addChild(new SScreen());
    stage.root.child.add(scroll);

    //
    TinyButton button = new TinyButton("test", 100.0, 100.0, (String b){print("---push sButton ${b}");});
    button.mat.translate(100.0,100.0,0.0);
    //stage.root.child.add(button);
    scroll.child.add(button);
    return (stage as TinyFlutterStage);
  }
}

class SScreen extends TinyDisplayObject {
  SScreen() {
  }
  bool onTouch(TinyStage stage, int id, String type, double x, double y, double globalX, globalY){
    return false;
  }

  void onPaint(TinyStage stage, TinyCanvas canvas) {
    TinyPaint p = new TinyPaint();
    p.color = new TinyColor.argb(0xaa, 0xaa, 0xaa, 0xff);
    p.style = TinyPaintStyle.stroke;
    p.strokeWidth = 10.0;
    for(int i=0;i<10;i++) {
      for(int j=0;j<10;j++) {
      TinyRect r = new TinyRect(50.0+i*100, 50.0+j*100, 100.0, 100.0);
      canvas.drawRect(stage, r, p);
    }
    }
  }

}
