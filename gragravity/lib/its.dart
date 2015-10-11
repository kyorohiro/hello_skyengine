part of gragravity;

class RegidBody extends Particle {
  double a = 0.0; // anglar
  double da = 0.0;
}

class StaticparticlRect extends RegidBody {
  @override
  void onTick(Stage stage, int timeStamp) {
  }
}

class Particle extends DisplayObject {
  // F = M * L / (T**2)
  // F = M * a
  // M / (L**3)
  // L / T
  // L**2
  double m = 0.1;
  double x = 100.0;// center of gravity
  double y = 100.0;// center of gravity
  double dx = 2.0;
  double dy = 0.0;

  void onTick(Stage stage, int timeStamp) {
    x += dx;
    y += dy;
    print("${dx} ${dy} ${x} ${y}");
  }

  void onPaint(Stage stage, PaintingCanvas canvas) {
    double size = 20.0;
    Paint p = new Paint()..color = const Color.fromARGB(0xaa, 0xff, 0xff, 0xaa);
    canvas.drawOval(new Rect.fromLTWH(stage.envX(x-size/2), stage.envY(y-size/2), size, size), p);
  }

}

class PlanetWorld extends DisplayObject {
  double gravity = 0.9807/10;
  void onTick(Stage stage, int timeStamp) {
    for(DisplayObject d in child) {
      if(d is Particle) {
        (d as Particle).dy -= gravity;
        if(d.y < 0) {
          d.dy = -1*d.dy * 0.95;
          d.y = 0.0;
        }
        else if(d.y > 200) {
          d.dy = -1*d.dy * 0.95;
          d.y = 200.0;
        }
        else if(d.x < 0) {
          d.dx = -1*d.dx * 0.95;
          d.x = 0.0;
        }
        else if(d.x > 200) {
          d.dx = -1*d.dx * 0.95;
          d.x = 200.0;
        }
      }
    }
  }


}
