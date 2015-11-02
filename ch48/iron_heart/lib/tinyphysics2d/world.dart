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

  List<Primitive> searchPrimitive(Primitive base, double direction, double range, double startDist, double endDist) {
    double s2 = normalizeAngle(direction);
    double starting = s2 - range;
    double ending = s2 + range;

    List<Primitive> ret = [];
    for (Primitive t in primitives) {
      double d = World.distance(base, t);
      double a = World.angleFromP2(t, base);
      if(!(startDist<=d && d<=endDist)) {
        continue;
      }
      double ss = a - starting;
      double ee = a - ending;
      if (ss >= 0 && ee <= 0) {
        ret.add(t);
      } else {
      }
    }
    return ret;
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

  static double normalizeAngle(double a) {
    a += math.PI * 2 * 4;
    a = a % (2 * math.PI);
    if (a < math.PI) {
      return a;
    } else {
      return -math.PI + (a - math.PI);
    }
  }

}
