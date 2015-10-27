part of tinygame;
abstract class TinyStage {
  double get x;
  double get y;
  double get w;
  double get h;
  double get paddingTop;
  double get paddingBottom;
  double get paddingRight;
  double get paddingLeft;

  bool animeIsStart = false;
  int animeId = 0;
  TinyDisplayObject _root;
  TinyDisplayObject get root => _root;
  TinyGameBuilder get builder;
  bool startable = false;
  bool isInit = false;

  void start();
  void stop();
  void markNeedsPaint();

  //
  //
  List<Matrix4> mats = [new Matrix4.identity()];

  pushMulMatrix(Matrix4 mat) {
    mats.add(mats.last*mat);
    //mats.add(mat*mats.last);
  }

  popMatrix() {
    mats.removeLast();
  }

  Matrix4 getMatrix() {
    return mats.last;
  }
}
