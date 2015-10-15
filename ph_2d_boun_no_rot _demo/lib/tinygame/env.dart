part of tinygame;

abstract class TinyGameBuilder {
  TinyStage createStage(TinyDisplayObject root);
  TinyRect createRect(double x, double y, double w, double h);
  TinyPaint createPaint();
  TinyColor createColor(int a, int r, int g, int b);
  TinyPoint createPoint(double x, double y);
}

class TinyGameBuilderForFlutter extends TinyGameBuilder {
  TinyStage createStage(TinyDisplayObject root) {
    return new TinyFlutterStage(root);
  }

  TinyRect createRect(double x, double y, double w, double h) {
    return new TinyRectForFlutter(x, y, w, h);
  }

  TinyPaint createPaint() {
    return new TinyPaintForFlutter();
  }

  TinyColor createColor(int a, int r, int g, int b) {
    return new TinyColorForFlutter(a, r, g, b);
  }
  TinyPoint createPoint(double x, double y) {
    return new TinyPointForFlutter(x, y);
  }
}

class TinyRectForFlutter extends TinyRect {
  double x;
  double y;
  double w;
  double h;
  TinyRectForFlutter(this.x, this.y, this.w, this.h) {}
}

class TinyPaintForFlutter extends TinyPaint {}

class TinyColorForFlutter extends TinyColor {
  TinyColorForFlutter(int a, int r, int g, int b) {
    value |= (a & 0xff) << 24;
    value |= (r & 0xff) << 16;
    value |= (g & 0xff) << 8;
    value |= (b & 0xff) << 0;
    value &= 0xFFFFFFFF;
  }
}
class TinyPointForFlutter extends TinyPoint {
  TinyPointForFlutter(double x, double y){
    this.x = x;
    this.y = y;
  }
}

abstract class TinyRect {
  double x;
  double y;
  double w;
  double h;
}

abstract class TinyPoint {
  double x;
  double y;
}

abstract class TinyPaint {
  TinyColor color;
}

abstract class TinyColor {
  int value = 0;
}

abstract class TinyCanvas {
  void drawOval(TinyStage stage, TinyRect rect, TinyPaint paint);
  void drawLine(TinyStage stage, TinyPoint p1, TinyPoint p2, TinyPaint paint);
}

abstract class TinyStage {
  double get x;
  double get y;
  double get w;
  double get h;
  bool animeIsStart = false;
  int animeId = 0;
  TinyDisplayObject _root;
  TinyDisplayObject get root => _root;
  bool startable = false;
  bool isInit = false;
  void start();
  void stop();
  void markNeedsPaint();
  double envY(double y) {
    return h / 2 - y;
  }

  double envX(double x) {
    return x + w / 2;
  }
}
