part of spacewar;

class Sun extends DisplayObject {
  void onPaint(Stage stage, PaintingCanvas canvas) {
    Paint paint = new Paint();
    Point point = new Point(stage.w / 2 + stage.x, stage.h / 2 * stage.h);
    paint.color = const Color.fromARGB(0xff, 0xff, 0xaa, 0xaa);
    canvas.drawCircle(point, 2 * math.PI, paint);
  }
}
