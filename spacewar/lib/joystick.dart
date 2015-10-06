part of spacewar;

class Joystick extends DisplayObject {

  double width = 50.0;
  double minWidth = 25.0;

  @override
  void onInit(Stage stage) {
    this.width = stage.h/6;
    this.minWidth = this.width/2;
    this.x = stage.w / 2 + stage.x;
    this.y = (stage.h - this.width) + stage.y;
  }

  @override
  void onPaint(Stage stage, PaintingCanvas canvas) {
    Paint paint1 = new Paint();
    paint1.color = const Color.fromARGB(0xaa, 0xff, 0xaa, 0xaa);
    Paint paint2 = new Paint();
    paint2.color = const Color.fromARGB(0xaa, 0xff, 0xaa, 0xaa);
    Rect r1 = new Rect.fromLTWH(x - width/2, y - width/2, width, width);
    Rect r2 = new Rect.fromLTWH(x - minWidth/2, y - minWidth/2, minWidth, minWidth);
    canvas.drawOval(r1, paint1);
    canvas.drawOval(r2, paint2);
  }

}
