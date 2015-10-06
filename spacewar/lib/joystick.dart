part of spacewar;

class Joystick extends DisplayObject {

  double width = 50.0;
  double minWidth = 25.0;
  bool isTouch = false;
  int touchId = 0;

  @override
  void onInit(Stage stage) {
    this.width = stage.h/6;
    this.minWidth = this.width/2;
    this.x = stage.w / 2 + stage.x;
    this.y = (stage.h - this.width) + stage.y;
  }

  @override
  void onPaint(Stage stage, PaintingCanvas canvas) {
    Paint paint = new Paint();
    if(isTouch) {
      paint.color = const Color.fromARGB(0xaa, 0xaa, 0xaa, 0xff);
    } else {
      paint.color = const Color.fromARGB(0xaa, 0xff, 0xaa, 0xaa);
    }
    Rect r1 = new Rect.fromLTWH(x - width/2, y - width/2, width, width);
    Rect r2 = new Rect.fromLTWH(x - minWidth/2, y - minWidth/2, minWidth, minWidth);
    canvas.drawOval(r1, paint);
    canvas.drawOval(r2, paint);
  }

  @override
  void onTouch(Stage stage, int id, String type, double x, double y, double dx, double dy) {
    print("onTouch ${id} ${type} ${x} ${y} ${dx} ${dy}");
    if(isTouch == false && distance(x, y, this.x, this.y) < minWidth) {
      isTouch = true;
    } else if(id == touchId && type == "pointerup") {
        isTouch = false;
    }
  }

  double distance(double x1, double y1, double x2, double y2) {
    return math.sqrt(math.pow(x1-x2,2)+math.pow(y1-y2,2));
  }
}
