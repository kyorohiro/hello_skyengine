part of gragravity;

class RegidBody extends Particle {
  double a = 0.0; // anglar
  double da = 0.0;
}

class Particle extends DisplayObject {
  // F = M * L / (T**2)
  // F = M * a
  // M / (L**3)
  // L / T
  // L**2
  double m = 0.1;
  double x = 0.0;// center of gravity
  double y = 0.0;// center of gravity
  double dx = 0.0;
  double dy = 0.0;

  void onTick(Stage stage, int timeStamp) {
    x += dx;
    y += dy;
    print("${dx} ${dy}");
  }

  void onPaint(Stage stage, PaintingCanvas canvas) {
    double size = 20.0;
    Paint p = new Paint()..color = const Color.fromARGB(0xaa, 0xff, 0xff, 0xaa);
    canvas.drawOval(new Rect.fromLTWH(envX(x-size/2), envY(y-size/2), size, size), p);
  }

  double envY(double y) {
    return -y;
  }

  double envX(double x) {
    return x;
  }
}

class  PlanetWorld extends DisplayObject {
  double gravity = 0.9807/100;
  void onTick(Stage stage, int timeStamp) {
    for(DisplayObject d in child) {
      if(d is Particle) {
        (d as Particle).dy -= gravity;
      }
    }
  }
}
