part of tinygame;


class TinyButton extends TinyDisplayObject {
  double w;
  double h;
  bool isTouch = false;
  TinyColor bgcolorOff = new TinyColor.argb(0xaa, 0xff, 0xaa, 0xcc);
  TinyColor bgcolorOn = new TinyColor.argb(0xaa, 0xcc, 0xaa, 0xff);
  TinyColor bgcolorFocus = new TinyColor.argb(0xaa, 0xcc, 0xff, 0xaa);
  TinyButton(this.w, this.h) {}

  void onTouch(TinyStage stage, int id, String type, double x, double y) {
    if ((type == "pointerdown" || type == "pointermove") &&
        x > 0 &&
        y > 0 &&
        y < h &&
        x < w) {
      //print("touch: ${x} ${y}");
      isTouch = true;
    } else {
      //print("untouch: ${x} ${y}");
      isTouch = false;
    }
  }

  void onPaint(TinyStage stage, TinyCanvas canvas) {
    TinyPaint paint = new TinyPaint();
    if (isTouch) {
      paint.color = bgcolorOn;
      canvas.drawRect(stage, new TinyRect(0.0, 0.0, w, h), paint);
    } else {
      paint.color = bgcolorOff;
      canvas.drawRect(stage, new TinyRect(0.0, 0.0, w, h), paint);
    }
  }
}
