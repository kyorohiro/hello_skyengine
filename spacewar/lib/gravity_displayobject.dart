part of spacewar;

class GravityDisplayObject extends DisplayObject {
  double angle = 0.0;
  double dx = 0.0;
  double dy = 0.5;

  @override
  void onPaint(Stage stage, PaintingCanvas canvas) {
    ;
  }

  void onTick(Stage stage, int timeStamp) {
    updateFromSun(stage, timeStamp);
  }

  void updateFromSun(Stage stage, int timeStamp) {
    DisplayObject sun = stage.root.fincObjectFromObjectName("sun");
    Joystick joystick = stage.root.fincObjectFromObjectName("joystick");
    if (sun != null) {
      double tx = sun.x - this.x;
      double ty = sun.y - this.y;
      double distance = math.sqrt(math.pow(tx, 2) + math.pow(ty, 2));
      double da = 100.0 / math.pow(distance, 2);
      double tt = (tx > 0 ? tx : -1 * tx) + (ty > 0 ? ty : -1 * ty);
      dx += da * (tx / tt);
      dy += da * (ty / tt);
    }
    x += dx;
    y += dy;
  }

  double abs(double v) {
    return (v > 0 ? v : -1 * v);
  }

  Point conv(double x, double y) {
    Matrix4 mat = new Matrix4.identity();
    Vector4 vec = new Vector4(x-this.x,y-this.y,1.0,1.0);
    mat.rotateZ(math.PI*angle/180);
    Vector4 out = mat * vec;
    return new Point(out.x+this.x, out.y+this.y);
  }
}
