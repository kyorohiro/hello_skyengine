part of tinygame;

class TinyDisplayObject {
  double x = 0.0;
  double y = 0.0;
  String objectName = "none";
  List<TinyDisplayObject> child = [];

  TinyDisplayObject({this.child: null}) {
    if (child == null) {
      child = [];
    }
  }

  TinyDisplayObject fincObjectFromObjectName(String objectName) {
    if (this.objectName == objectName) {
      return this;
    }
    for (TinyDisplayObject d in child) {
      TinyDisplayObject t = d.fincObjectFromObjectName(objectName);
      if (t != null) {
        return t;
      }
    }
    return null;
  }

  addChild(TinyDisplayObject d) async {
    await new Future.value();
    child.add(d);
  }

  rmChild(TinyDisplayObject d) async {
    await new Future.value();
    child.remove(d);
    d.unattach();
  }

  void onInit(TinyStage stage) {}

  void init(TinyStage stage) {
    onInit(stage);
    for (TinyDisplayObject d in child) {
      d.init(stage);
    }
  }

  void onTick(TinyStage stage, int timeStamp) {}

  void tick(TinyStage stage, int timeStamp) {
    onTick(stage, timeStamp);
    for (TinyDisplayObject d in child) {
      d.tick(stage, timeStamp);
    }
  }

  void onPaint(TinyStage stage, TinyCanvas canvas) {
    ;
  }

  void paint(TinyStage stage, TinyCanvas canvas) {
    onPaint(stage, canvas);
    for (TinyDisplayObject d in child) {
      d.paint(stage, canvas);
    }
  }

  void touch(TinyStage stage, int id, String type,
    double x, double y, double dx, double dy) {
    onTouch(stage, id, type, x, y, dx, dy);
    for (TinyDisplayObject d in child) {
      d.touch(stage, id, type, x, y, dx, dy);
    }
  }

  void onTouch(TinyStage stage, int id, String type,
    double x, double y, double dx, double dy) {}

  void onUnattach() {}

  void unattach() {
    onUnattach();
    for (TinyDisplayObject d in child) {
      d.unattach();
    }
  }
}
