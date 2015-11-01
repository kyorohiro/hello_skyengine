part of tinygame;

class TinySeekbar extends TinyDisplayObject {
  double viewWidth;
  double viewHeight;
  double range = 0.3;
  bool get isVertical => viewWidth < viewHeight;

  TinyColor fgColor = new TinyColor.argb(0xaa, 0xaa, 0xaa, 0xff);
  TinySeekbar(this.viewWidth, this.viewHeight) {}

  bool onTouch(TinyStage stage, int id, String type, double x, double y,
      double globalX, globalY) {
    if (isVertical) {
      onTouchVertical(stage, id, type, x, y, globalX, globalY);
    } else {
      onTouchHorizontal(stage, id, type, x, y, globalX, globalY);
    }
  }

  void onPaint(TinyStage stage, TinyCanvas canvas) {
    if (isVertical) {
      paintVertical(stage, canvas);
    } else {
      paintHorizontal(stage, canvas);
    }
  }

  bool onTouchHorizontal(TinyStage stage, int id, String type, double x,
      double y, double globalX, globalY) {
    if (0 <= x && x <= viewWidth) {
      if (0 <= y && y <= viewHeight) {
        range = x / viewWidth;
      }
    }
  }

  bool onTouchVertical(TinyStage stage, int id, String type, double x, double y,
      double globalX, globalY) {
    if (0 <= x && x <= viewWidth) {
      if (0 <= y && y <= viewHeight) {
        range = y / viewHeight;
      }
    }
  }

  paintHorizontal(TinyStage stage, TinyCanvas canvas) {
    TinyPaint p = new TinyPaint();
    p.style = TinyPaintStyle.stroke;
    p.strokeWidth = this.viewHeight;
    p.color = fgColor;
    double cx = 0.0;
    double cy = this.viewHeight / 2.0;
    canvas.drawLine(
        stage, new TinyPoint(cx, cy), new TinyPoint(cx + viewWidth, cy), p);
    canvas.drawLine(stage, new TinyPoint(cx + (viewWidth) * range - 10.0, cy),
        new TinyPoint(cx + (viewWidth) * range + 10.0, cy), p);
  }

  paintVertical(TinyStage stage, TinyCanvas canvas) {
    TinyPaint p = new TinyPaint();
    p.style = TinyPaintStyle.stroke;
    p.strokeWidth = this.viewWidth;
    p.color = fgColor;

    double cx = this.viewWidth / 2.0;
    double cy = 0.0;

    canvas.drawLine(
        stage, new TinyPoint(cx, cy), new TinyPoint(cx, cy + viewHeight), p);
    canvas.drawLine(stage, new TinyPoint(cx, cy + (viewHeight) * range - 10.0),
        new TinyPoint(cx, cy + (viewHeight) * range + 10.0), p);
  }
}
