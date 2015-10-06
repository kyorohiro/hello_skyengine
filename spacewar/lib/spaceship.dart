part of spacewar;

class SpaceShip extends DisplayObject {
  double angle = 0.0;
  double dx = 0.0;
  double dy = 0.5;
  @override
  String objectName = "spaceship";

  SpaceShip() {
    x = 400.0;
    y = 300.0;
  }

  @override
  void onPaint(Stage stage, PaintingCanvas canvas) {

    Paint paint = new Paint();
    paint.color = const Color.fromARGB(0xaa, 0xff, 0xaa, 0xaa);

    canvas.drawLine(conv(x, y), conv(x + 10.0, y + 30.0), paint);
    canvas.drawLine(conv(x - 10.0, y + 30.0), conv(x + 10.0, y + 30.0), paint);
    canvas.drawLine(conv(x - 10.0, y + 30.0), conv(x, y), paint);
  }

  Point conv(double x, double y) {
    Matrix4 mat = new Matrix4.identity();
    Vector4 vec = new Vector4(x-this.x,y-this.y,1.0,1.0);
    mat.rotateZ(math.PI*angle/180);
    Vector4 out = mat * vec;
    return new Point(out.x+this.x, out.y+this.y);
  }

  void onTick(Stage stage, double timeStamp) {
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
    if(joystick != null) {
      angle += joystick.directionX/10.0;
    }
    x += dx;
    y += dy;
  }
}