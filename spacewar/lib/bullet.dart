part of spacewar;

class Bullet extends GravityDisplayObject {

  int liveTime = 60*1000;
  int birthTime = 0;

  Bullet() {
    birthTime = new DateTime.now().millisecondsSinceEpoch;
  }

  @override
  void onPaint(Stage stage, Canvas canvas) {
    Paint paint = new Paint();
    paint.color = const Color.fromARGB(0xaa, 0xff, 0xff, 0x00);
    Rect r = new Rect.fromLTWH(x - 5.0, y - 5.0, 10.0, 10.0);
    canvas.drawOval(r, paint);

    int time = new DateTime.now().millisecondsSinceEpoch;
    if(time-birthTime > liveTime) {
      stage.root.rmChild(this);
    }

    Enemy enemy = stage.root.fincObjectFromObjectName("enemy");
    if(enemy != null) {
      double tx = enemy.x - this.x;
      double ty = enemy.y - this.y;
      double distance = math.sqrt(math.pow(tx, 2) + math.pow(ty, 2));
      if(distance < enemy.size/2) {
        enemy.life -= 1;
        stage.root.rmChild(this);
      }
    }
  }
}
