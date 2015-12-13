part of spacewar;

class Sun extends DisplayObject {
  @override
  String objectName = "sun";

  Paint p = new Paint();
  Color c = new Color.fromARGB(0xaa, 0xff, 0xaa, 0xaa);
  Rect r = new Rect.fromLTWH(0.0, 0.0, 0.0, 0.0);

  Sun() {
    p.color = c;
  }

  @override
  void onInit(Stage stage) {
    this.x = stage.w / 2 + stage.x;
    this.y = stage.h / 2 + stage.y;
    this.r = new Rect.fromLTWH(x - 5.0, y - 5.0, 10.0, 10.0);
  }

  @override
  void onPaint(Stage stage, Canvas canvas) {
    canvas.drawOval(r, p);
  }
}
