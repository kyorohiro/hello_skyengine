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
}
