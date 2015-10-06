part of spacewar;

class Sun extends DisplayObject {
  void onPaint(Stage stage, PaintingCanvas canvas) {
    Paint paint = new Paint();
    Point point = new Point(stage.w / 2 + stage.x, stage.h / 2 + stage.y);
    print("point = ${point.x} ${point.y}");
    paint.color = const Color.fromARGB(0xaa, 0xff, 0xaa, 0xaa);
    Rect r = new Rect.fromLTWH(point.x-5.0, point.y-5.0, 10.0, 10.0);
    canvas.drawOval(r, paint);
  }
}
