part of tinygame;

class TinyGameBuilderForFlutter extends TinyGameBuilder {
  Map<String, TinyImage> cach = {};

  TinyStage createStage(TinyDisplayObject root) {
    return new TinyFlutterStage(this, root);
  }

  Future<TinyImage> loadImage(String path) async {
    if(cach.containsKey(path)) {
      return cach[path];
    }
    cach[path] = new TinyFlutterImage(await ImageLoader.load(path));
    return cach[path];
  }

  Future clearCash() {
    cach.clear();
  }
}

class TinyFlutterImage implements TinyImage {
  sky.Image rawImage;
  TinyFlutterImage(this.rawImage) {}
  int get w => rawImage.width;
  int get h => rawImage.height;
}

class ImageLoader {
  static AssetBundle getAssetBundle() {
    if (rootBundle != null) {
      return rootBundle;
    } else {
      return new NetworkAssetBundle(new Uri.directory(Uri.base.origin));
    }
  }

  static Future<sky.Image> load(String url) async {
    AssetBundle bundle = getAssetBundle();
    ImageResource resource = bundle.loadImage(url);
    return resource.first;
  }
}

class TinyFlutterStage extends RenderBox with TinyStage {
  double get x => paintBounds.left;
  double get y => paintBounds.top;
  double get w => paintBounds.width;
  double get h => paintBounds.height;

  double get paddingTop => sky.view.paddingTop;
  double get paddingBottom => sky.view.paddingBottom;
  double get paddingRight => sky.view.paddingRight;
  double get paddingLeft => sky.view.paddingLeft;

  bool animeIsStart = false;
  int animeId = 0;
  TinyDisplayObject _root;
  TinyDisplayObject get root => _root;
  bool startable = false;
  static const int kMaxOfTouch = 5;
  Map<int, TouchPoint> touchPoints = {};
  bool isInit = false;

  TinyGameBuilder _builder;
  TinyGameBuilder get builder => _builder;

  TinyFlutterStage(this._builder, this._root) {
    init();
  }

  void init() {}

  void start() {
    if (animeIsStart == true) {
      return;
    }
    animeIsStart = true;
    isInit = false;
    animeId = scheduler.requestAnimationFrame(_innerTick);
  }

  void _innerTick(Duration timeStamp) {
    if (startable) {
      if (isInit == false) {
        _root.init(this);
        isInit = true;
      }
      _root.tick(this, timeStamp.inMilliseconds);
      this.markNeedsPaint();
    }
    if (animeIsStart == true) {
      animeId = scheduler.requestAnimationFrame(_innerTick);
    }
  }

  void stop() {
    if (animeIsStart == true) {
      scheduler.cancelAnimationFrame(animeId);
    }
    animeIsStart = false;
  }

  @override
  void performLayout() {
    size = constraints.biggest;
    startable = true;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    root.paint(this, new TinyFlutterCanvas(context.canvas));
  }

  @override
  void handleEvent(InputEvent event, HitTestEntry en) {
    if (!(event is PointerInputEvent || !(en is BoxHitTestEntry))) {
      return;
    }

    BoxHitTestEntry entry = en;
    PointerInputEvent e = event;
    if (!touchPoints.containsKey(e.pointer)) {
      touchPoints[e.pointer] = new TouchPoint(-1.0, -1.0);
    }

    if (event.type == "pointerdown") {
      touchPoints[e.pointer].x = entry.localPosition.x;
      touchPoints[e.pointer].y = entry.localPosition.y;
    } else {
      touchPoints[e.pointer].x += (e.dx == null ? 0 : e.dx);
      touchPoints[e.pointer].y += (e.dy == null ? 0 : e.dy);
    }
    _root.touch(this, e.pointer, event.type, touchPoints[e.pointer].x,
        touchPoints[e.pointer].y);

    if (event.type == "pointerup") {
      touchPoints.remove(e.pointer);
    }
    if (event.type == "pointercancel") {
      touchPoints.clear();
    }
  }
}

class TinyFlutterCanvas extends TinyCanvas {
  PaintingCanvas canvas;
  TinyFlutterCanvas(this.canvas) {}

  void drawOval(TinyStage stage, TinyRect rect, TinyPaint paint) {
    Paint p = new Paint()..color = new Color(paint.color.value);
    canvas.drawOval(new Rect.fromLTWH(rect.x, rect.y, rect.w, rect.h), p);
  }

  Paint toPaint(TinyPaint p) {
    Paint pp = new Paint();
    pp.color = new Color(p.color.value);
    pp.strokeWidth = p.strokeWidth;
    switch (p.style) {
      case TinyPaintStyle.fill:
        pp.style = sky.PaintingStyle.fill;
        break;
      case TinyPaintStyle.stroke:
        pp.style = sky.PaintingStyle.stroke;
        break;
    }
    return pp;
  }

  void drawLine(TinyStage stage, TinyPoint p1, TinyPoint p2, TinyPaint paint) {
    canvas.drawLine(
        new Point(p1.x, p1.y), new Point(p2.x, p2.y),
        toPaint(paint));
  }

  void drawRect(TinyStage stage, TinyRect rect, TinyPaint paint) {
    canvas.drawRect(new Rect.fromLTWH(rect.x, rect.y, rect.w, rect.h),
    toPaint(paint));
  }

  void clipRect(TinyStage stage, TinyRect rect) {
    canvas.clipRect(new Rect.fromLTWH(rect.x, rect.y, rect.w, rect.h));
  }

  void drawImageRect(TinyStage stage, TinyImage image, TinyRect src,
      TinyRect dst, TinyPaint paint) {
    Rect s = new Rect.fromLTWH(src.x, src.y, src.w, src.h);
    Rect d = new Rect.fromLTWH(dst.x, dst.y, dst.w, dst.h);
    sky.Image i = (image as TinyFlutterImage).rawImage;
    canvas.drawImageRect(i, s, d,
//      new Paint());
    toPaint(paint));
  }

  void updateMatrix() {
    canvas.setMatrix(this.getMatrix().storage);
  }
}

class TouchPoint {
  double x;
  double y;
  TouchPoint(this.x, this.y) {}
}
