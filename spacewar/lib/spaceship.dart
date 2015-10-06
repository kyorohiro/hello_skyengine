part of spacewar;

class SpaceShip extends GravityDisplayObject {
  bool isThrust = false;
  @override
  String objectName = "spaceship";

  @override
  void onInit(Stage stage) {
    this.x = stage.w * 2/ 3 + stage.x;
    this.y = stage.h * 2/ 3 + stage.y;
  }

  @override
  void onPaint(Stage stage, PaintingCanvas canvas) {
    Paint paint = new Paint();
    if(isThrust == true) {
      paint.color = const Color.fromARGB(0xaa, 0xff, 0x22, 0x22);
    } else {
      paint.color = const Color.fromARGB(0xaa, 0xff, 0xaa, 0xaa);
    }
    canvas.drawLine(conv(x, y-15),               conv(x + 10.0, y-15 + 30.0), paint);
    canvas.drawLine(conv(x - 10.0, y-15 + 30.0), conv(x + 10.0, y-15 + 30.0), paint);
    canvas.drawLine(conv(x - 10.0, y-15 + 30.0), conv(x, y-15), paint);
  }


  void onTick(Stage stage, double timeStamp) {
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
      }
    }
    x += dx;
    y += dy;
  }


}
