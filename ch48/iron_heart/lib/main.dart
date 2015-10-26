import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'tinygame.dart';
import 'dart:math' as math;
import 'dart:async';
import 'package:flutter/services.dart';

TinyGameBuilderForFlutter f = new TinyGameBuilderForFlutter();

void main() {
  runApp(new GameWidget());
}

class GameWidget extends OneChildRenderObjectWidget {
  RenderObject createRenderObject() {
    TinyStage stage = f.createStage(new TinyGameRoot(800.0, 600.0));
    stage.start();
    stage.root.child.add(new TinyButton(600.0, 200.0)..mat=new Matrix4.translationValues(100.0,300.0,0.0));
    return (stage as TinyFlutterStage);
  }
}


class StartScreen extends TinyDisplayObject {}
