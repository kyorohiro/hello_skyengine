library spacewar;

import 'package:sky/widgets.dart';
import 'package:sky/rendering.dart';
import 'dart:math' as math;
part 'sun.dart';

abstract class DisplayObject {
  List<DisplayObject> child = [];
  void onPaint(Stage stage, PaintingCanvas canvas);
}

class Stage {
  int x = 0;
  int y = 0;
  int w = 500;
  int h = 500;
}
