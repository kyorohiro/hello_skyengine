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
  List<TouchPoint> touchPoints = [];
  bool isInit = false;

  TinyFlutterStage(this._root) {
    init();
  }

  void init() {
    for (int i = 0; i < kMaxOfTouch; i++) {
      touchPoints.add(new TouchPoint(-1.0, -1.0));
    }
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
    root.paint(this, context.canvas);
  }

  @override
  void handleEvent(sky.Event event, BoxHitTestEntry entry) {
    if (!(event is sky.PointerEvent)) {
      return;
    }
    sky.PointerEvent e = event;
    if (e.pointer >= kMaxOfTouch) {
      return;
    }

    if (event.type == "pointerdown") {
      touchPoints[e.pointer].x = entry.localPosition.x;
      touchPoints[e.pointer].y = entry.localPosition.y;
    } else {
      touchPoints[e.pointer].x += e.dx;
      touchPoints[e.pointer].y += e.dy;
    }
    _root.touch(this, e.pointer, event.type, touchPoints[e.pointer].x,
        touchPoints[e.pointer].y, e.dx, e.dy);
  }


}

class TouchPoint {
  double x;
  double y;
  TouchPoint(this.x, this.y) {}
}
