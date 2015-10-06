part of spacewar;

class Bullet extends GravityDisplayObject {

  int liveTime = 60*1000;
  int birthTime = 0;

  Bullet() {
    birthTime = new DateTime.now().millisecondsSinceEpoch;
  }

  @override
  void onPaint(Stage stage, PaintingCanvas canvas) {
    Paint paint = new Paint();
    paint.color = const Color.fromARGB(0xaa, 0xff, 0xff, 0x00);
    Rect r = new Rect.fromLTWH(x - 5.0, y - 5.0, 10.0, 10.0);
    canvas.drawOval(r, paint);

    int time = new DateTime.now().millisecondsSinceEpoch;
    if(time-birthTime > liveTime) {
      stage.root.rmChild(this);
    }
  }
}
