part of tinygame;

class TinyGameRoot extends TinyDisplayObject {
  double w = 800.0;
  double h = 600.0;
  double ratioW = 1.0;
  double ratioH = 1.0;
  double radio = 1.0;
  double l = 0.0;
  double t = 0.0;
  TinyColor bkcolor;
  Matrix4 mat = new Matrix4.identity();

  TinyGameRoot({this.bkcolor}) {
    if (bkcolor == null) {
      bkcolor = new TinyColor.argb(0xff, 0xee, 0xee, 0xff);
    }
  }

  void updatePosition(TinyStage stage, int timeStamp) {
    ratioW = stage.w / w;
    ratioH = stage.h / h;
    radio = (ratioW < ratioH ? ratioW : ratioH);
    l = (stage.w - (w * radio)) / 2;
    mat = new Matrix4.identity();
    mat.scale(radio, radio, 1.0);
    mat.translate(l, t, 0.0);
  }

  void onTick(TinyStage stage, int timeStamp) {
    updatePosition(stage, timeStamp);
  }

  void paint(TinyStage stage, TinyCanvas canvas) {
    canvas.pushMulMatrix(mat);
    super.paint(stage, canvas);
    canvas.popMatrix();
  }

  void onPaint(TinyStage stage, TinyCanvas canvas) {
    TinyRect rect = new TinyRect(0.0, 0.0, w, h);
    TinyPaint paint = new TinyPaint();
    paint.color = bkcolor;

    canvas.clipRect(stage, rect);
    canvas.drawRect(stage, rect, paint);
  }
}

class TinyButton extends TinyDisplayObject {
  double w;
  double h;
  bool isTouch = false;
  TinyColor bgcolor = new TinyColor.argb(0xaa, 0xff, 0xaa, 0xcc);

  TinyButton(this.w, this.h) {
  }

  void onTouch(TinyStage stage, int id, String type, double x, double y) {
    if((type=="pointerdown" || type =="pointermove") && x >0 && y>0 && y<h && x<w) {
      isTouch = true;
    } else {
      isTouch = false;
    }
  }

  void onPaint(TinyStage stage, TinyCanvas canvas) {
    TinyPaint paint = new TinyPaint();
    if(isTouch) {
      paint.color = new TinyColor(bgcolor.value & 0xffaabbaa );
      canvas.drawRect(stage, new TinyRect(0.0, 0.0, w, h), paint);
    } else {
      paint.color = bgcolor;
      canvas.drawRect(stage, new TinyRect(0.0, 0.0, w, h), paint);
    }
  }
}
