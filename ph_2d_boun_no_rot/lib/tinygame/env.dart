part of tinygame;

abstract class TinyGameBuilder {
  TinyStage createStage(TinyDisplayObject root);
}

class TinyGameBuilderForFlutter extends TinyGameBuilder {
  TinyStage createStage(TinyDisplayObject root) {
    return new TinyFlutterStage(root);
  }
}

abstract class TinyStage {
  double get x;
  double get y;
  double get w;
  double get h;
  bool animeIsStart = false;
  int animeId = 0;
  TinyDisplayObject _root;
  TinyDisplayObject get root => _root;
  bool startable = false;
  bool isInit = false;
  void start();
  void stop();
  void markNeedsPaint();
  double envY(double y) {
    return h/2-y;
  }

  double envX(double x) {
    return x + w/2;
  }
}
