part of spacewar;

class Enemy extends DisplayObject {
  double width = 50.0;
  @override
  void onInit(Stage stage) {
    this.x = stage.w * 2/ 3 + stage.x;
    this.y = stage.h * 1/ 3 + stage.y;
  }

  @override
  void onPaint(Stage stage, PaintingCanvas canvas) {
    Paint paint = new Paint();
    paint.color = const Color.fromARGB(0xaa, 0x00, 0x00, 0xff);
    Rect r = new Rect.fromLTWH(x - width/2, y - width/2, width, width);
    canvas.drawOval(r, paint);
  }

  int prevTime = 0;
  int numOfBullet = 0;
  void onTick(Stage stage, int timeStamp) {
    if(timeStamp -prevTime > 500) {
      EnemyBullet bullet = new EnemyBullet();
      bullet.x = this.x;
      bullet.y = this.y;
      bullet.dy = 0.6;
      stage.root.addChild(bullet);
      numOfBullet++;
      prevTime = timeStamp;
    }
  }
}

class EnemyBullet extends GravityDisplayObject {

  int liveTime = 60*1000;
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
    if(spaceship != null) {
      double tx = spaceship.x - this.x;
      double ty = spaceship.y - this.y;
      double distance = math.sqrt(math.pow(tx, 2) + math.pow(ty, 2));
      if(distance < spaceship.size) {
        spaceship.life -= 1;
        stage.root.rmChild(this);
      }
    }
    int time = new DateTime.now().millisecondsSinceEpoch;
    if(time-birthTime > liveTime) {
      stage.root.rmChild(this);
    }
  }

}
