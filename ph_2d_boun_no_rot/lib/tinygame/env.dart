part of tinygame;

abstract class GameBuilder {
  Stage createStage(DisplayObject root);
}

class GameBuilderForFlutter extends GameBuilder {
  Stage createStage(DisplayObject root) {
    return new FlutterStage(root);
  }
}

abstract class Stage {
  double get x;
  double get y;
  double get w;
  double get h;
  bool animeIsStart = false;
  int animeId = 0;
  DisplayObject _root;
  DisplayObject get root => _root;
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
