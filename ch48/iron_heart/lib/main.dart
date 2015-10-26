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
    TinyStage stage = f.createStage(new TinyGameRoot());
    stage.start();
    stage.root.child.add(new TinyButton(100.0, 100.0)..y=100.0..x=60.0);
    return (stage as TinyFlutterStage);
  }
}


class StartScreen extends TinyDisplayObject {}
