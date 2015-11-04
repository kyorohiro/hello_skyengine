part of tinygame;

abstract class TinyGameBuilder {
  Map<String, TinyImage> cach = {};

  TinyStage createStage(TinyDisplayObject root);
  Future<TinyImage> loadImageBase(String path);
  Future<TinyImage> loadImage(String path) async {
    if (cach.containsKey(path)) {
      return cach[path];
    }
    cach[path] = await loadImageBase(path);
    return cach[path];
  }

  TinyImage getImage(String path) {
    if (cach.containsKey(path)) {
      return cach[path];
    }
    loadImage(path);
    return null;
  }

  Future clearCash() {
    cach.clear();
  }
}

class TinyRect {
  double x;
  double y;
  double w;
  double h;
  TinyRect(this.x, this.y, this.w, this.h) {}
}

class TinyPoint {
  double x;
  double y;
  TinyPoint(this.x, this.y) {}
}

enum TinyPaintStyle { fill, stroke }

class TinyPaint {
  TinyColor color;
  TinyPaintStyle style = TinyPaintStyle.fill;
  double strokeWidth = 1.0;
  TinyPaint({this.color}) {
    if (this.color == null) {
      color = new TinyColor.argb(0xff, 0xff, 0xff, 0xff);
    }
  }
}

class TinyColor {
  int value = 0;
  TinyColor(this.value) {}
  int get a => (value>>24) & 0xff;
  int get r => (value>>16) & 0xff;
  int get g => (value>>8)  & 0xff;
  int get b => (value>>0)  & 0xff;
  double get af => a/255.0;
  double get rf => r/255.0;
  double get gf => g/255.0;
  double get bf => b/255.0;

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
