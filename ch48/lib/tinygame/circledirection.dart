part of tinygame;

typedef void TinyCircleDirectionCallback (
  String id,
  double angle,
  double range,
  double distance);

class TinyCircleDirection extends TinyDisplayObject {
  String id;
  double circleSize;
  double rangeWidth;
  double distanceWidth;
  double angle = 0.0;
  double range = 0.3;
  double distance = 0.3;
  TinyColor fgColor = new TinyColor.argb(0xaa, 0xaa, 0xaa, 0xff);
  TinyCircleDirectionCallback callback;

  TinyCircleDirection(this.id, this.circleSize,
    this.rangeWidth, this.distanceWidth, this.callback) {}

  bool onTouch(TinyStage stage, int id, String type, double x, double y,
      double globalX, globalY) {
    bool ret1 = onTouchCircle(stage, id, type, x, y, globalX, globalY);
    bool ret2 = onTouchRange(stage, id, type, x, y, globalX, globalY);
    bool ret3 = onTouchDistance(stage, id, type, x, y, globalX, globalY);
    print("${ret1} ${ret2} ${(ret1 || ret2)}");
    return (ret1 || ret2 || ret3);
  }

  bool onTouchCircle(TinyStage stage, int id, String type, double x, double y,
      double globalX, globalY) {
    double cx = circleSize / 2.0;
    double cy = circleSize / 2.0;
    if (math.sqrt((x - cx) * (x - cx) + (y - cy) * (y - cy)) <
        circleSize / 2.0) {
      angle = math.atan2(y - cy, x - cx) + math.PI / 2;
      callback(this.id, angle, range, distance);
      return true;
    }
    return false;
  }

  bool onTouchRange(TinyStage stage, int id, String type, double x, double y,
      double globalX, globalY) {
    double cx = circleSize + rangeWidth / 2;
    double cy = 0.0;
    if (circleSize < x && x < (circleSize + rangeWidth)) {
      if (0 < y && y < circleSize) {
        range = (y / circleSize) * math.PI;
        callback(this.id, angle, range, distance);
        return true;
      }
    }
    return false;
  }

  bool onTouchDistance(TinyStage stage, int id, String type, double x, double y,
      double globalX, globalY) {
    double cx = circleSize + rangeWidth + rangeWidth / 2;
    double cy = 0.0;
    if (circleSize + rangeWidth < x &&
        x < (circleSize + rangeWidth + rangeWidth)) {
      if (0 < y && y < circleSize) {
        distance = (y / circleSize);
        callback(this.id, angle, range, distance);
        return true;
      }
    }
    return false;
  }

  void onPaint(TinyStage stage, TinyCanvas canvas) {
    paintCircle(stage, canvas);
    paintRange(stage, canvas);
    paintDistance(stage, canvas);
  }

  paintRange(TinyStage stage, TinyCanvas canvas) {
    TinyPaint p = new TinyPaint();
    p.style = TinyPaintStyle.stroke;
    p.strokeWidth = rangeWidth / 3;
    p.color = fgColor;
    double cx = circleSize + rangeWidth / 2;
    double cy = 0.0;
    canvas.drawLine(
        stage, new TinyPoint(cx, cy), new TinyPoint(cx, cy + circleSize), p);
    p.color = new TinyColor.argb(0xff, 0x00, 0x00, 0x00);
    canvas.drawLine(
        stage,
        new TinyPoint(cx, cy + circleSize * (range / math.PI) - 10.0),
        new TinyPoint(cx, cy + circleSize * (range / math.PI) + 10.0),
        p);
  }

  paintDistance(TinyStage stage, TinyCanvas canvas) {
    TinyPaint p = new TinyPaint();
    p.style = TinyPaintStyle.stroke;
    p.strokeWidth = rangeWidth / 3;
    p.color = fgColor;
    double cx = circleSize + rangeWidth + rangeWidth / 2;
    double cy = 0.0;
    canvas.drawLine(
        stage, new TinyPoint(cx, cy), new TinyPoint(cx, cy + circleSize), p);
    p.color = new TinyColor.argb(0xff, 0x00, 0x00, 0x00);
    canvas.drawLine(
        stage,
        new TinyPoint(cx, cy + circleSize * (distance) - 10.0),
        new TinyPoint(cx, cy + circleSize * (distance) + 10.0),
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
        new TinyPoint(cx + distance * cx * math.cos(angle - math.PI / 2),
            cy + distance * cy * math.sin(angle - math.PI / 2)),
        p);

    double px = cx;
    double py = cy;
    for(int i=0;i<20;i++) {
      p.strokeWidth = 2.5;
      double qx = cx + distance * cx * math.cos(angle - range +range*2*(i/19.0)- math.PI / 2);
      double qy = cy + distance * cy * math.sin(angle - range +range*2*(i/19.0)- math.PI / 2);
      canvas.drawLine(
          stage,
          new TinyPoint(px, py),
          new TinyPoint(qx, qy),
          p);
      px = qx;
      py = qy;
    }
    p.strokeWidth = 2.5;
    canvas.drawLine(
        stage,
        new TinyPoint(cx, cy),
        new TinyPoint(
            cx + distance * cx * math.cos(angle - range - math.PI / 2),
            cy + distance * cy * math.sin(angle - range - math.PI / 2)),
        p);
    p.strokeWidth = 2.5;
    canvas.drawLine(
        stage,
        new TinyPoint(cx, cy),
        new TinyPoint(
            cx + distance * cx * math.cos(angle + range - math.PI / 2),
            cy + distance * cy * math.sin(angle + range - math.PI / 2)),
        p);
  }
}
