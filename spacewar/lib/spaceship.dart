part of spacewar;

class SpaceShip extends GravityDisplayObject {
  bool isThrust = false;
  int size = 20;
  double maxlife = 20.0;
  double life = 20.0;
  @override
  String objectName = "spaceship";

  @override
  void onInit(Stage stage) {
    this.x = stage.w * 2/ 3 + stage.x;
    this.y = stage.h * 2/ 3 + stage.y;
    this.angle = 0.0;
    this.dx = 0.0;
    this.dy = 0.5;
    this.life = maxlife;
    this.isLoop = true;
  }

  @override
  void onPaint(Stage stage, PaintingCanvas canvas) {
    Paint paint = new Paint();
    if(isThrust == true) {
      double v = (255.0*life/maxlife);
      paint.color = new  Color.fromARGB(0xaa, v.floor(), 0x22, 0x22);
    } else {
      double v = (255.0*life/maxlife);
      paint.color = new Color.fromARGB(0xaa, v.floor(), 0xaa, 0xaa);
    }
    canvas.drawLine(conv(x, y-15),               conv(x + 10.0, y-15 + 30.0), paint);
    canvas.drawLine(conv(x - 10.0, y-15 + 30.0), conv(x + 10.0, y-15 + 30.0), paint);
    canvas.drawLine(conv(x - 10.0, y-15 + 30.0), conv(x, y-15), paint);
  }


  void onTick(Stage stage, int timeStamp) {
    this.updateFromSun(stage, timeStamp);
    Joystick joystick = stage.root.fincObjectFromObjectName("joystick");

    if(joystick != null) {
      angle -= joystick.directionX/20.0;
      if(joystick.directionY > 0) {
        isThrust = true;
        dx += joystick.directionY * math.cos(math.PI*(angle-90)/180) / 5000;
        dy += joystick.directionY * math.sin(math.PI*(angle-90)/180) / 5000;
      } else {
        isThrust = false;
        if(joystick.directionY < -1*joystick.directionMax*2/5) {
          Bullet b = new Bullet();
          b.x = this.x;
          b.y = this.y;
          b.dx = this.dx + -1*joystick.directionY * math.cos(math.PI*(angle-90)/180) / 500;
          b.dy = this.dy + -1*joystick.directionY * math.sin(math.PI*(angle-90)/180) / 500;
          stage.root.addChild(b);
        }
      }
    }
    x += dx;
    y += dy;
  }


}
