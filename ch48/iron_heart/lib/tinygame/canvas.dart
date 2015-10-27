part of tinygame;

abstract class TinyCanvas {
  void drawOval(TinyStage stage, TinyRect rect, TinyPaint paint);
  void drawRect(TinyStage stage, TinyRect rect, TinyPaint paint);
  void drawLine(TinyStage stage, TinyPoint p1, TinyPoint p2, TinyPaint paint);
  void clipRect(TinyStage stage, TinyRect rect);
  void drawImageRect(TinyStage stage,
    TinyImage image, TinyRect src, TinyRect dst, TinyPaint paint);
  List<Matrix4> mats = [new Matrix4.identity()];

  pushMulMatrix(Matrix4 mat) {
    mats.add(mats.last*mat);
  //  mats.add(mat*mats.last);
    updateMatrix();
  }

  popMatrix() {
    mats.removeLast();
    updateMatrix();
  }

  Matrix4 getMatrix() {
    return mats.last;
  }

  void updateMatrix();
}
