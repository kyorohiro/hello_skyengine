part of spacewar;

class Enemy extends GravityDisplayObject {
  @override
  String objectName = "enemy";
  math.Random rand = new math.Random();
  double maxlife = 50.0;
  double life = 200.0;
  double size = 50.0;

  @override
  void onInit(Stage stage) {
    //  if(this.life > 0) {
    //    this.x = stage.w * 2/ 3 + stage.x;
    //    this.y = stage.h * 1/ 3 + stage.y;
    //  } else {
    this.x = stage.w * (rand.nextInt(5) + 1) / 6.0 + stage.x;
    this.y = stage.h * (rand.nextInt(5) + 1) / 6.0 + stage.y;
    this.dx = 0.0;
    this.dy = 0.0;
    //  }
    this.life = this.maxlife;
    this.isLoop = true;
  }

  @override
  void onPaint(Stage stage, PaintingCanvas canvas) {
    Paint paint = new Paint();
    double v = (255.0 * life / maxlife);
    v = (v > 0 ? v : 0);
    paint.color = new Color.fromARGB(0xaa, 0x00, 0x00, v.floor());
    Rect r = new Rect.fromLTWH(x - size / 2, y - size / 2, size, size);
    canvas.drawOval(r, paint);
  }

  int prevTime = 0;
  int numOfBullet = 0;
  void onTick(Stage stage, int timeStamp) {
    this.updateFromSun(stage, timeStamp);
    dx = (dx > 0?(dx>0.5?0.5:dx):(dx<-0.5?-0.5:dx));
    dy = (dy > 0?(dy>0.5?0.5:dy):(dy<-0.5?-0.5:dy));
    if (timeStamp - prevTime > 500) {
      EnemyBullet bullet = new EnemyBullet();
      bullet.x = this.x;
      bullet.y = this.y;
      switch (numOfBullet % 3) {
        case 0:
        SpaceShip spaceship =
            stage.root.fincObjectFromObjectName("spaceship");
        if (spaceship != null) {
          bullet.dx = -1*(spaceship.x - this.x) / 800.0;
          bullet.dy = (spaceship.y - this.y) / 800.0;
        }
        break;
        case 1:
          SpaceShip spaceship =
              stage.root.fincObjectFromObjectName("spaceship");
          if (spaceship != null) {
            bullet.dx = (spaceship.x - this.x) / 800.0;
            bullet.dy = (spaceship.y - this.y) / 800.0;
          }
          break;
        case 2:
          Sun sun = stage.root.fincObjectFromObjectName("sun");
          if (sun != null) {
            bullet.dy = (sun.x - this.x) / 800.0;
            bullet.dx = -1*(sun.y - this.y) / 800.0;
          }

          break;
      }
      stage.root.addChild(bullet);
      numOfBullet++;
      prevTime = timeStamp;
    } else {
      Sun sun = stage.root.fincObjectFromObjectName("sun");
      if (sun != null) {
        List<double> dxdy = this.calcGravityDxDy(sun);
        this.dx += -1.2*dxdy[1];
        this.dy += 1.2*dxdy[0];
      }
      dx = (dx > 0?(dx>0.5?0.5:dx):(dx<-0.5?-0.5:dx));
      dy = (dy > 0?(dy>0.5?0.5:dy):(dy<-0.5?-0.5:dy));
    }
  }
}

class EnemyBullet extends GravityDisplayObject {
  int liveTime = 60 * 1000;
  int birthTime = 0;

  EnemyBullet() {
    birthTime = new DateTime.now().millisecondsSinceEpoch;
  }

  @override
  void onPaint(Stage stage, PaintingCanvas canvas) {
    Paint paint = new Paint();
    paint.color = const Color.fromARGB(0xaa, 0xff, 0x00, 0x00);
    Rect r = new Rect.fromLTWH(x - 5.0, y - 5.0, 10.0, 10.0);
    canvas.drawOval(r, paint);

    SpaceShip spaceship = stage.root.fincObjectFromObjectName("spaceship");
    if (spaceship != null) {
      double tx = spaceship.x - this.x;
      double ty = spaceship.y - this.y;
      double distance = math.sqrt(math.pow(tx, 2) + math.pow(ty, 2));
      if (distance < spaceship.size) {
        spaceship.life -= 1;
        stage.root.rmChild(this);
      }
    }
    int time = new DateTime.now().millisecondsSinceEpoch;
    if (time - birthTime > liveTime) {
      stage.root.rmChild(this);
    }
  }
}