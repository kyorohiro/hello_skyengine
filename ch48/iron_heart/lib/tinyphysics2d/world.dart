part of tinyphysics2d;
class World {
  Vector3 gravity = new Vector3(0.0, 0.0, 0.0);
  List<Primitive> primitives = [];
  next(double time) {
    primitives.shuffle();
    for (Primitive a in primitives) {
      for (Primitive b in primitives) {
        if (a != b && a.checkCollision(b)) {
          a.collision(b);
        }
      }
      if (a.isFixing == false) {
        a.dxy.x += gravity.x;
        a.dxy.y += gravity.y;
      }
      a.next(time);
    }
  }

  static double distance(Primitive p1, Primitive p2) {
    double x = p1.xy.x - p2.xy.x;
    double y = p1.xy.y - p2.xy.y;
    return math.sqrt(x * x + y * y);
  }

  static double angleFromP2(Primitive p1, Primitive p2) {
    double x = p1.xy.x - p2.xy.x;
    double y = p1.xy.y - p2.xy.y;
    return math.atan2(y, x);
  }
}
