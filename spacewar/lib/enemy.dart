part of spacewar;

class Enemy extends GravityDisplayObject {
  @override
  String objectName = "enemy";
  math.Random rand = new math.Random();
  double maxlife = 50.0;
  double life = 200.0;
  double size = 50.0;
  int prevTime = 0;
  int numOfBullet = 0;
  Rect enemySize = new Rect();
  Paint enemyPaint = new Paint();
  @override
  void onInit(Stage stage) {
    this.x = stage.w * (rand.nextDouble() * 4.0 + 1.0) / 6.0 + stage.x;
    this.y = stage.h * (rand.nextDouble() * 4.0 + 1.0) / 6.0 + stage.y;
    this.dx = 0.0;
    this.dy = 0.0;
    this.life = this.maxlife;
    this.isLoop = true;
    this.prevTime = 0;
    this.numOfBullet = 0;
  }

  @override
  void onPaint(Stage stage, PaintingCanvas canvas) {
    double colorDepth = abs(255.0 * life / maxlife);
    enemyPaint.color = new Color.fromARGB(0xaa, 0x00, 0x00, colorDepth.floor());
    enemySize = new Rect.fromLTWH(x - size / 2, y - size / 2, size, size);
    canvas.drawOval(enemySize, enemyPaint);
  }

  @override
  void updateFromSun(stage, timeStamp) {
    super.updateFromSun(stage, timeStamp);
    Sun sun = stage.root.fincObjectFromObjectName("sun");
    if (sun != null) {
      List<double> dxdy = calcGravityDxDy(sun);
      if ((abs(this.dx) +abs(this.dx) /2)> 2.6) {
        this.dx += -0.1 * dxdy[0];
        this.dy += -0.1 * dxdy[1];
      }
      //[da * (tx / tt), da * (ty / tt), da, distance, tx, ty];
      if (abs(dx -dxdy[0])+abs(dy -dxdy[1]) < 0.5) {
        print("##${abs(dx -dxdy[0])} ${abs(dy -dxdy[1])}");
        double m = 0.25;
        this.dx += -m * dxdy[1] / dxdy[2];
        this.dy += m * dxdy[0] / dxdy[2];
      }
    }
  }

  void shot(Stage stage, int timeStamp) {
    if (timeStamp - prevTime > 250) {
      EnemyBullet bullet = new EnemyBullet();
      bullet.x = this.x;
      bullet.y = this.y;
      switch (numOfBullet % 2) {
        case 0:
          bullet.dx = this.dx*0.8-0.2*this.dy;
          bullet.dy = this.dy*0.8+0.2*this.dx;
          break;
        case 1:
          bullet.dx = this.dx*0.8+0.2*this.dy;
          bullet.dy = this.dy*0.8-0.2*this.dx;
        break;
        case 4:
          SpaceShip spaceship =
              stage.root.fincObjectFromObjectName("spaceship");
          if (spaceship != null) {
            bullet.dx = (spaceship.x - this.x) / 800.0;
            bullet.dy = (spaceship.y - this.y) / 800.0;
          }
          break;
        case 5:
          Sun sun = stage.root.fincObjectFromObjectName("sun");
          if (sun != null) {
            bullet.dy = (sun.x - this.x) / 800.0;
            bullet.dx = -1 * (sun.y - this.y) / 800.0;
          }
          break;
      }
      stage.root.addChild(bullet);
      numOfBullet++;
      prevTime = timeStamp;
    }
  }

  void onTick(Stage stage, int timeStamp) {
    updateFromSun(stage, timeStamp);
    shot(stage, timeStamp);
  }
}
