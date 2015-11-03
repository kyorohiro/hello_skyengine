part of tinygame;


class TinyScrollView extends TinyDisplayObject {

  double dx = 0.0;
  double dy = 0.0;
  double currentLeft = 0.0;
  double currentTop = 0.0;
  double viewWidth;
  double viewHeight;
  double contentWidth;
  double contentHeight;

  TinyScrollView(this.viewWidth, this.viewHeight,
    this.contentWidth, this.contentHeight) {
  }

  void onTick(TinyStage stage, int timeStamp) {
    dx *=0.9;
    dy *=0.9;
    currentLeft += dx;
    currentTop += dy;
    if(currentLeft < -1*(contentWidth-viewWidth)) {
      double left = -1*(contentWidth-viewWidth);
      dx = (left-currentLeft)/10;
    }
    if(currentTop < -1*(contentHeight-viewHeight)) {
       double top= -1*(contentHeight-viewHeight);
       dy = (top-currentTop)/10;
    }
    if(currentTop > 0.0) {
      double top = 0.0;
      dy = (top-currentTop)/10;
    }
    if(currentLeft > 0.0) {
      double left = 0.0;
      dx = (left-currentLeft)/10;
    }
  }

  double px = 0.0;
  double py = 0.0;
  void onTouchEnd(TinyStage stage, int id, String type, double x, double y){
    Matrix4 tmp = stage.getMatrix().clone();
    tmp.invert();
    Vector3 a = tmp * new Vector3(x, y, 0.0);
    switch(type) {
      case "pointerdown":
        px = x;
        py = y;
      break;
      case "pointermove":
        dx = (x-px)*2.2;
        dy = (y-py)*2.2;
        //currentLeft += dx;
        //currentTop += dy;
        px = x;
        py = y;
      break;
    }
  }
  bool touch(TinyStage stage, int id, String type, double x, double y) {

    Matrix4 mat = new Matrix4.identity();
    mat.translate(currentLeft, currentTop, 0.0);
    stage.pushMulMatrix(mat);
    bool ret = super.touch(stage, id, type, x, y);
    stage.popMatrix();
    print("---${ret}");
    return ret;
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
