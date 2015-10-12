part of gragravity;

class Primitive {
  bool checkCollision(Primitive p) {
    return false;
  }
  void next(int t) {
  }

  void collision(Primitive p) {

  }
}

class World {
  List<Primitive> primitives = [];
  next(int time) {
    for(Primitive a in primitives) {
      for(Primitive b in primitives) {
        if(a!=b && a.checkCollision(b)) {
          print("----coll");
          a.collision(b);
        }
      }
      a.next(time);
    }
  }
}
class Box extends Primitive {
  double mass = 1.0;
  double angle = 0.0;
  double elastic = 0.8;

  Vector3 centerOfGravity = new Vector3.zero();
  Vector3 leftTop = new Vector3(-25.0, -25.0, 0.0);
  Vector3 rightBottom = new Vector3(25.0, 25.0, 0.0);
  Vector3 speed = new Vector3(0.0, 0.0, 0.0);

  bool checkCollision(Primitive p) {
    if (p is Box) {
    //  if (rightBottom.x < p.leftTop.x || leftTop.x > p.rightBottom.x) {
    //    return false;
    //  }
    //
      if (rightBottom.y < p.leftTop.y || leftTop.y > p.rightBottom.y) {
        return false;
      }
      print("${rightBottom.y} < ${p.leftTop.y} || ${leftTop.y} > ${p.rightBottom.y}");
      return true;
    }
    return false;
  }

  void size(double w, double h) {
    leftTop.x = centerOfGravity.x - w/2;
    leftTop.y = centerOfGravity.y - h/2;
    rightBottom.x = centerOfGravity.x + w/2;
    rightBottom.y = centerOfGravity.x + h/2;
  }

  void move(double dx, double dy) {
    centerOfGravity.x +=dx;
    centerOfGravity.y +=dy;
    rightBottom.x += dx;
    rightBottom.y += dy;
    leftTop.x += dx;
    leftTop.y += dy;
  }
  void next(int t) {
    double dx = speed.x;
    double dy = speed.y;
    move(dx, dy);
  }

  void collision(Primitive p) {
    speed.y = -1*speed.y * elastic;
  }
}

class PlanetWorld extends DisplayObject {
  World w  = new World();
  PlanetWorld() {
    w.primitives.add(new Box()..move(0.0, 100.0)..speed.y=-1.0);
    w.primitives.add(new Box()..size(400.0,20.0));
  }
  void onTick(Stage stage, int timeStamp) {
    w.next(timeStamp);
    stage.markNeedsPaint();
  }

  void onPaint(Stage stage, PaintingCanvas canvas) {
    for(Primitive p in w.primitives) {
      if(p is Box) {
        Rect r = new Rect.fromLTRB(
          stage.envX(p.leftTop.x), stage.envY(p.leftTop.y),
          stage.envX(p.rightBottom.x), stage.envY(p.rightBottom.y));
        Paint pa = new Paint()..color = const Color.fromARGB(0xaa, 0xff, 0xff, 0xaa);
       canvas.drawRect(r, pa);
      }
    }
  }
}
