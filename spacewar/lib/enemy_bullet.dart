part of spacewar;

class EnemyBullet extends GravityDisplayObject {
  int liveTime = 60 * 1000;
  int birthTime = 0;

  EnemyBullet() {
    birthTime = new DateTime.now().millisecondsSinceEpoch;
  }

  @override
  void onPaint(Stage stage, Canvas canvas) {
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
