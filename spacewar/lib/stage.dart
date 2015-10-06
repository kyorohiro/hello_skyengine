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
  Stage(this._root) {}
  bool startable = false;

  void start() {
    if (animeIsStart == true) {
      return;
    }
    animeIsStart = true;
    bool isInit = false;
    innerTick(double timeStamp) {
      if (startable) {
        if (isInit == false) {
          _root.init(this);
          isInit = true;
        }
        if (_root != null) {
          _root.tick(this, timeStamp);
        }
        this.markNeedsPaint();
      }
      if (animeIsStart == true) {
        animeId = scheduler.requestAnimationFrame(innerTick);
      }
    }
    animeId = scheduler.requestAnimationFrame(innerTick);
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
  void handleEvent(sky.Event event, BoxHitTestEntry entry) {}
}
