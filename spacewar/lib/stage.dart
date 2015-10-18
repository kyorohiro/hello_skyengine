part of spacewar;

class Stage extends RenderBox {
  double get x => paintBounds.left;
  double get y => paintBounds.top;
  double get w => paintBounds.width;
  double get h => paintBounds.height;
  bool animeIsStart = false;
  int animeId = 0;
  DisplayObject _root;
  DisplayObject get root => _root;
  bool startable = false;
  static const int kMaxOfTouch = 5;
  Map<int, TouchPoint> touchPoints = {};
  bool isInit = false;

  Stage(this._root) {}

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
  void handleEvent(InputEvent event, HitTestEntry entry) {
    if (!(event is PointerInputEvent || !(entry is BoxHitTestEntry))) {
      return;
    }

    PointerInputEvent e = event;
    if (!touchPoints.containsKey(e.pointer)) {
      BoxHitTestEntry en = entry;
      touchPoints[e.pointer] =
          new TouchPoint(en.localPosition.x, en.localPosition.y);
    }
    print("${event.type}");
    switch (event.type) {
      case "pointermove":
        // 2015/10/18 return null
        touchPoints[e.pointer].x += (e.dx == null ? 0.0 : e.dx);
        touchPoints[e.pointer].y += (e.dy == null ? 0.0 : e.dy);
        break;
    }
    _root.touch(
        this,
        e.pointer,
        event.type,
        touchPoints[e.pointer].x,
        touchPoints[e.pointer].y,
        // 2015/10/18 return null
        (e.dx == null ? 0.0 : e.dx),
        (e.dy == null ? 0.0 : e.dy));
    switch (event.type) {
      case "pointerup":
        touchPoints.remove(e.pointer);
        break;
      case 'pointercancel':
        touchPoints.clear();
        break;
    }
  }
}

class TouchPoint {
  double x;
  double y;
  TouchPoint(this.x, this.y) {}
}
