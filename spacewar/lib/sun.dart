part of spacewar;

class Sun extends DisplayObject {
  @override
  void onPaint(Stage stage, PaintingCanvas canvas) {
    Paint paint = new Paint();
    Point point = new Point(stage.w / 2 + stage.x, stage.h / 2 + stage.y);
    print("point = ${point.x} ${point.y}");
    paint.color = const Color.fromARGB(0xaa, 0xff, 0xaa, 0xaa);
    Rect r = new Rect.fromLTWH(point.x-5.0, point.y-5.0, 10.0, 10.0);
    canvas.drawOval(r, paint);
  }
}

class SpaceShip extends DisplayObject {
  double x = 100.0;
  double y = 100.0;
  double angle = 0.0;

  @override
  void onPaint(Stage stage, PaintingCanvas canvas) {
    Paint paint = new Paint();
    paint.color = const Color.fromARGB(0xaa, 0xff, 0xaa, 0xaa);
    canvas.drawLine(new Point(x, y),          new Point(x+10.0,y+30.0), paint);
    canvas.drawLine(new Point(x-10.0,y+30.0), new Point(x+10.0,y+30.0), paint);
    canvas.drawLine(new Point(x-10.0,y+30.0), new Point(x,y), paint);
  }
}
