part of tinygame;

class TinyFlutterStage extends RenderBox with TinyStage {
  double get x => paintBounds.left;
  double get y => paintBounds.top;
  double get w => paintBounds.width;
  double get h => paintBounds.height;
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

  void init() {
  }

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
    if(touchPoints.containsKey(e.pointer)) {
      touchPoints[e.pointer] = new TouchPoint(-1.0, -1.0);
    }

    if (event.type == "pointerdown") {
      touchPoints[e.pointer].x = entry.localPosition.x;
      touchPoints[e.pointer].y = entry.localPosition.y;
    } else {
      touchPoints[e.pointer].x += (e.dx == null?0:e.dx);
      touchPoints[e.pointer].y += (e.dy == null?0:e.dy);
    }
    _root.touch(this, e.pointer, event.type, touchPoints[e.pointer].x,
        touchPoints[e.pointer].y, (e.dx == null?0:e.dx), (e.dy == null?0:e.dy));

    if (event.type == "pointerup") {
      touchPoints.remove(e.pointer);
    }
    if(event.type == "pointercancel") {
      touchPoints.clear();
    }
  }



}

class TinyFlutterCanvas extends TinyCanvas {
  PaintingCanvas canvas;
  TinyFlutterCanvas(this.canvas) {
  }

  void drawOval(TinyStage stage, TinyRect rect, TinyPaint paint) {
    Paint p = new Paint()..color=new Color(paint.color.value);
    canvas.drawOval(new Rect.fromLTWH(stage.envX(rect.x), stage.envY(rect.y), rect.w, rect.h), p);
  }

  void drawLine(TinyStage stage, TinyPoint p1, TinyPoint p2, TinyPaint paint) {
    Paint p = new Paint()..color=new Color(paint.color.value);
    canvas.drawLine(new Point(stage.envX(p1.x), stage.envY(p1.y)), new Point(stage.envX(p2.x), stage.envY(p2.y)), p);
  }

  void drawRect(TinyStage stage, TinyRect rect, TinyPaint paint) {
    Paint p = new Paint()..color=new Color(paint.color.value);
    canvas.drawRect(new Rect.fromLTWH(stage.envX(rect.x), stage.envY(rect.y), rect.w, rect.h), p);
  }
}

class TouchPoint {
  double x;
  double y;
  TouchPoint(this.x, this.y) {}
}
