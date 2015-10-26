part of tinygame;

abstract class TinyGameBuilder {
  TinyStage createStage(TinyDisplayObject root);

}

class TinyGameBuilderForFlutter extends TinyGameBuilder {
  TinyStage createStage(TinyDisplayObject root) {
    return new TinyFlutterStage(this, root);
  }
}

class TinyRect {
  double x;
  double y;
  double w;
  double h;
  TinyRect(this.x, this.y, this.w, this.h){}
}

class TinyPoint {
  double x;
  double y;
  TinyPoint(this.x, this.y){}
}

class TinyPaint {
  TinyColor color;
  TinyPaint({this.color}){;}
}

class TinyColor {
  int value = 0;
  TinyColor(this.value){}
  TinyColor.argb(int a, int r, int g, int b) {
    value |= (a & 0xff) << 24;
    value |= (r & 0xff) << 16;
    value |= (g & 0xff) << 8;
    value |= (b & 0xff) << 0;
    value &= 0xFFFFFFFF;
  }
}

abstract class TinyCanvas {
  void drawOval(TinyStage stage, TinyRect rect, TinyPaint paint);
  void drawRect(TinyStage stage, TinyRect rect, TinyPaint paint);
  void drawLine(TinyStage stage, TinyPoint p1, TinyPoint p2, TinyPaint paint);
  void clipRect(TinyStage stage, TinyRect rect);
  List<Matrix4> mats = [new Matrix4.identity()];

  pushMulMatrix(Matrix4 mat) {
    mats.add(mats.last*mat);
    updateMatrix();
  }

  popMatrix() {
    mats.removeLast();
    updateMatrix();
  }

  Matrix4 getMatrix() {
    return mats.last;
  }

  void updateMatrix();
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
  TinyGameBuilder get builder;
  bool startable = false;
  bool isInit = false;

  void start();
  void stop();
  void markNeedsPaint();
}
