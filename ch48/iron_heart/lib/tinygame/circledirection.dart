part of tinygame;

class TinyCircleDirection extends TinyDisplayObject {
  double viewWidth;
  double rangeWidth;
  double angle = 0.0;
  double range = 0.3;
  TinyColor fgColor = new TinyColor.argb(0xaa, 0xaa, 0xaa, 0xff);

  TinyCircleDirection(this.viewWidth, this.rangeWidth) {}

  bool onTouch(TinyStage stage, int id, String type, double x, double y,
      double globalX, globalY) {
    double cx = viewWidth / 2.0;
    double cy = viewWidth / 2.0;
    if (math.sqrt((x - cx) * (x - cx) + (y - cy) * (y - cy)) <
        viewWidth / 2.0) {
      angle = math.atan2(y - cy, x - cx) + math.PI / 2;
    }
  }

  void onPaint(TinyStage stage, TinyCanvas canvas) {
    paintCircle(stage, canvas);
  }

  paintCircle(TinyStage stage, TinyCanvas canvas) {
    TinyPaint p = new TinyPaint();
    p.style = TinyPaintStyle.stroke;
    p.strokeWidth = 5.0;
    TinyRect rect = new TinyRect(0.0, 0.0, viewWidth, viewWidth);
    canvas.drawOval(stage, rect, p);

    p.color = fgColor;
    double cx = viewWidth / 2.0;
    double cy = viewWidth / 2.0;
    canvas.drawLine(
        stage,
        new TinyPoint(cx, cy),
        new TinyPoint(cx + cx * math.cos(angle - math.PI / 2),
            cy + cy * math.sin(angle - math.PI / 2)),
        p);
    canvas.drawLine(
        stage,
        new TinyPoint(cx, cy),
        new TinyPoint(cx + cx * math.cos(angle -range- math.PI / 2),
            cy + cy * math.sin(angle -range- math.PI / 2)),
        p);
    canvas.drawLine(
        stage,
        new TinyPoint(cx, cy),
        new TinyPoint(cx + cx * math.cos(angle +range- math.PI / 2),
            cy + cy * math.sin(angle +range- math.PI / 2)),
        p);
  }
/*
  paintRange(TinyStage stage, TinyCanvas canvas) {
    TinyPaint p = new TinyPaint();
    p.style = TinyPaintStyle.stroke;
    p.strokeWidth = 5.0;
    TinyRect rect = new TinyRect(0.0, 0.0, viewWidth, viewWidth);
    canvas.drawOval(stage, rect, p);

    p.color = fgColor;
    double cx = viewWidth/2.0;
    double cy = viewWidth/2.0;
    canvas.drawLine(stage,
      new TinyPoint(cx, cy),
      new TinyPoint(cx+cx*math.cos(angle-math.PI/2), cy+cy*math.sin(angle-math.PI/2)),
      p);
  }*/
}
