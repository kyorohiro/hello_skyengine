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
    root.paint(this, context.canvas);
  }
  @override
  bool hitTest(HitTestResult result, {Point position}) {
    result.add(new BoxHitTestEntry(this, position));
    return true;
  }
  @override
  void handleEvent(PointerEvent event, HitTestEntry entry) {
    if (!(entry is BoxHitTestEntry)) {
      return;
    }

    if (!touchPoints.containsKey(event.pointer)) {
      BoxHitTestEntry en = entry;
      touchPoints[event.pointer] =
          new TouchPoint(en.localPosition.x, en.localPosition.y);
    }
    if(event is PointerMoveEvent) {
        touchPoints[event.pointer].x = event.position.x;
        touchPoints[event.pointer].y = event.position.y;
    }
    _root.touch(
        this,
        event.pointer,
        toEvent(event),
        touchPoints[event.pointer].x,
        touchPoints[event.pointer].y,
        // 2015/10/18 return null
        event.position.x,
        event.position.y);
    if(event is PointerUpEvent) {
        touchPoints.remove(event.pointer);
    } else if(event is PointerCancelEvent) {
        touchPoints.clear();
    }
  }
}
String toEvent(PointerEvent e) {
  if(e is PointerUpEvent) {
    return "pointerup";
  }else if(e is PointerDownEvent) {
    return "pointerdown";
  }else if(e is PointerCancelEvent) {
    return "pointercancel";
  }else if(e is PointerMoveEvent) {
    return "pointermove";
  }
}
class TouchPoint {
  double x;
  double y;
  TouchPoint(this.x, this.y) {}
}
