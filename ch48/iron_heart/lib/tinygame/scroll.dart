part of tinygame;


class TinyScrollView extends TinyDisplayObject {

  double currentLeft = 0.0;
  double currentTop = 0.0;
  double viewWidth;
  double viewHeight;

  TinyScrollView(this.viewWidth, this.viewHeight) {
  }

  void onTick(TinyStage stage, int timeStamp) {

  }

  double px = 0.0;
  double py = 0.0;
  void onTouch(TinyStage stage, int id, String type, double x, double y) {
    switch(type) {
      case "pointerdown":
        px = x;
        py = y;
      break;
      case "pointermove":
        currentLeft += x-px;
        currentTop += y-py;
        px = x;
        py = y;
      break;
    }
  }

  void paint(TinyStage stage, TinyCanvas canvas) {
    TinyRect rect = new TinyRect(0.0, 0.0, viewWidth, viewHeight);
    canvas.pushClipRect(stage, rect);
    Matrix4 mat = new Matrix4.identity();
    mat.translate(currentLeft, currentTop, 0.0);
    canvas.pushMulMatrix(mat);
    super.paint(stage, canvas);
    canvas.popMatrix();
    canvas.popClipRect(stage);
  }

  void onPaint(TinyStage stage, TinyCanvas canvas) {
    ;
  }
}
