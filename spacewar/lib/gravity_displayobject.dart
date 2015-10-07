part of spacewar;

class GravityDisplayObject extends DisplayObject {
  double angle = 0.0;
  double dx = 0.0;
  double dy = 0.5;
  bool isLoop = false;

  void onTick(Stage stage, int timeStamp) {
    updateFromSun(stage, timeStamp);
  }

  List<double> calcGravityDxDy(DisplayObject sun) {
    double tx = sun.x - this.x;
    double ty = sun.y - this.y;
    double distance = math.sqrt(math.pow(tx, 2) + math.pow(ty, 2));
    double da = 100.0 / math.pow(distance, 2);
    double tt = abs(tx) + abs(ty);
    return [da * (tx / tt), da * (ty / tt), da, distance, tx, ty];
  }

  void updateFromSun(Stage stage, int timeStamp) {
    DisplayObject sun = stage.root.fincObjectFromObjectName("sun");
    if (sun != null) {
      List<double> dxdy = calcGravityDxDy(sun);
      dx += dxdy[0];
      dy += dxdy[1];
    }
    x += dx;
    y += dy;
    if (isLoop == true) {
      updateFromScreenEdge(stage, timeStamp);
    }
  }

  void updateFromScreenEdge(Stage stage, int timeStamp) {
    if (stage.w - this.x < 30) {
      this.x = stage.x + 30;
    } else if (this.x < 30) {
      this.x = stage.w - 30;
    }
    if (stage.h - this.y < 30) {
      this.y = stage.y + 30;
    } else if (this.y < 30) {
      this.y = stage.h - 30;
    }
  }

  double abs(double v) {
    return (v > 0 ? v : -1 * v);
  }

  Point conv(double x, double y) {
    Matrix4 mat = new Matrix4.identity();
    Vector4 vec = new Vector4(x - this.x, y - this.y, 1.0, 1.0);
    mat.rotateZ(math.PI * angle / 180);
    Vector4 out = mat * vec;
    return new Point(out.x + this.x, out.y + this.y);
  }
}
