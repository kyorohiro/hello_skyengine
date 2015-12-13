part of tinygame;

class TinyFlutterStage extends RenderBox with TinyStage{
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

  TinyFlutterStage(this._root) {
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
    animeId = scheduler.addFrameCallback(_innerTick);
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
      animeId = scheduler.addFrameCallback(_innerTick);
    }
  }

  void stop() {
    if (animeIsStart == true) {
      scheduler.cancelFrameCallbackWithId(animeId);
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
  void handleEvent(PointerEventevent, HitTestEntry en) {
  }
}

class TinyFlutterCanvas extends TinyCanvas {
  Canvas canvas;
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

}

class TouchPoint {
  double x;
  double y;
  TouchPoint(this.x, this.y) {}
}
