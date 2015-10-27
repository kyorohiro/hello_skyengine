part of tinygame;

abstract class TinyGameBuilder {
  TinyStage createStage(TinyDisplayObject root);
  Future<TinyImage> loadImage(String path);
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

enum TinyPaintStyle {
  fill,
  stroke
}

class TinyPaint {
  TinyColor color;
  TinyPaintStyle  style = TinyPaintStyle.fill;
  double strokeWidth = 1.0;
  TinyPaint({this.color}){
    if(this.color == null) {
      color = new TinyColor.argb(0xff, 0xff, 0xff, 0xff);
    }
  }
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

abstract class TinyImage {
  int get h;
  int get w;
}
