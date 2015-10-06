part of spacewar;

class Sun extends DisplayObject {
  @override
  String objectName = "sun";

  @override
  void onInit(Stage stage) {
    this.x = stage.w / 2 + stage.x;
    this.y = stage.h / 2 + stage.y;
  }

  @override
  void onPaint(Stage stage, PaintingCanvas canvas) {
    Paint paint = new Paint();
    paint.color = const Color.fromARGB(0xaa, 0xff, 0xaa, 0xaa);
    Rect r = new Rect.fromLTWH(x - 5.0, y - 5.0, 10.0, 10.0);
    canvas.drawOval(r, paint);
  }
}
