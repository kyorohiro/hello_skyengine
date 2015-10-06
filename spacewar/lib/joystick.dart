part of spacewar;

class Joystick extends DisplayObject {

  @override
  void onPaint(Stage stage, PaintingCanvas canvas) {
    Paint paint = new Paint();
    paint.color = const Color.fromARGB(0xaa, 0xff, 0xaa, 0xaa);
    Rect r = new Rect.fromLTWH(x - 5.0, y - 5.0, 50.0, 50.0);
    canvas.drawOval(r, paint);
  }

}
