part of tinygame;

class TinyCircleDirection extends TinyDisplayObject {
  double circleSize;
  double rangeWidth;
  double angle = 0.0;
  double range = 0.3;
  TinyColor fgColor = new TinyColor.argb(0xaa, 0xaa, 0xaa, 0xff);

  TinyCircleDirection(this.circleSize, this.rangeWidth) {}

  bool onTouch(TinyStage stage, int id, String type, double x, double y,
      double globalX, globalY) {
    bool ret1 = onTouchCircle(stage, id, type, x, y, globalX, globalY);
    bool ret2 = onTouchRange(stage, id, type, x, y, globalX, globalY);
    print("${ret1} ${ret2} ${(ret1 || ret2)}");
    return (ret1 || ret2);
  }

  bool onTouchCircle(TinyStage stage, int id, String type, double x, double y,
      double globalX, globalY) {
    double cx = circleSize / 2.0;
    double cy = circleSize / 2.0;
    if (math.sqrt((x - cx) * (x - cx) + (y - cy) * (y - cy)) <
        circleSize / 2.0) {
        angle = math.atan2(y - cy, x - cx) + math.PI / 2;
        return true;
    }
    return false;
  }
  bool onTouchRange(TinyStage stage, int id, String type, double x, double y,
      double globalX, globalY) {
    double cx = circleSize+ rangeWidth/2;
    double cy = 0.0;
    if(circleSize<x && x<(circleSize+rangeWidth)) {
      if(0<y && y<circleSize) {
         range = (y/circleSize)*math.PI;
         return true;
      }
    }
    return false;
  }
  void onPaint(TinyStage stage, TinyCanvas canvas) {
    paintCircle(stage, canvas);
    paintRange(stage, canvas);
  }

  paintRange(TinyStage stage, TinyCanvas canvas) {
    TinyPaint p = new TinyPaint();
    p.style = TinyPaintStyle.stroke;
    p.strokeWidth = rangeWidth/3;
    p.color = fgColor;
    double cx = circleSize+ rangeWidth/2;
    double cy = 0.0;
    canvas.drawLine(
        stage,
        new TinyPoint(cx, cy),
        new TinyPoint(cx, cy+circleSize),
        p);
    canvas.drawLine(
            stage,
            new TinyPoint(cx, cy+circleSize*(range/math.PI)-10.0),
            new TinyPoint(cx, cy+circleSize*(range/math.PI)+10.0),
            p);
  }

  paintCircle(TinyStage stage, TinyCanvas canvas) {
    TinyPaint p = new TinyPaint();
    p.style = TinyPaintStyle.stroke;

    TinyRect rect = new TinyRect(0.0, 0.0, circleSize, circleSize);
    canvas.drawOval(stage, rect, p);

    p.color = fgColor;
    double cx = circleSize / 2.0;
    double cy = circleSize / 2.0;

    p.strokeWidth = 15.0;
    canvas.drawLine(
        stage,
        new TinyPoint(cx, cy),
        new TinyPoint(
          cx + cx * math.cos(angle - math.PI / 2),
          cy + cy * math.sin(angle - math.PI / 2)),
        p);

    p.strokeWidth = 2.5;
    canvas.drawLine(
        stage,
        new TinyPoint(cx, cy),
        new TinyPoint(
          cx + cx * math.cos(angle -range- math.PI / 2),
          cy + cy * math.sin(angle -range- math.PI / 2)),
        p);
    p.strokeWidth = 2.5;
    canvas.drawLine(
        stage,
        new TinyPoint(cx, cy),
        new TinyPoint(
          cx + cx * math.cos(angle +range- math.PI / 2),
          cy + cy * math.sin(angle +range- math.PI / 2)),
        p);
  }
}
