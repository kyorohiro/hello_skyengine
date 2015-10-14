part of tinygame;

class DisplayObject {
  double x = 0.0;
  double y = 0.0;
  String objectName = "none";
  List<DisplayObject> child = [];

  DisplayObject({this.child: null}) {
    if (child == null) {
      child = [];
    }
  }

  DisplayObject fincObjectFromObjectName(String objectName) {
    if (this.objectName == objectName) {
      return this;
    }
    for (DisplayObject d in child) {
      DisplayObject t = d.fincObjectFromObjectName(objectName);
      if (t != null) {
        return t;
      }
    }
    return null;
  }

  addChild(DisplayObject d) async {
    await new Future.value();
    child.add(d);
  }

  rmChild(DisplayObject d) async {
    await new Future.value();
    child.remove(d);
    d.unattach();
  }

  void onInit(Stage stage) {}

  void init(Stage stage) {
    onInit(stage);
    for (DisplayObject d in child) {
      d.init(stage);
    }
  }

  void onTick(Stage stage, int timeStamp) {}

  void tick(Stage stage, int timeStamp) {
    onTick(stage, timeStamp);
    for (DisplayObject d in child) {
      d.tick(stage, timeStamp);
    }
  }

  void onPaint(Stage stage, PaintingCanvas canvas) {
    ;
  }

  void paint(Stage stage, PaintingCanvas canvas) {
    onPaint(stage, canvas);
    for (DisplayObject d in child) {
      d.paint(stage, canvas);
    }
  }

  void touch(Stage stage, int id, String type,
    double x, double y, double dx, double dy) {
    onTouch(stage, id, type, x, y, dx, dy);
    for (DisplayObject d in child) {
      d.touch(stage, id, type, x, y, dx, dy);
    }
  }

  void onTouch(Stage stage, int id, String type,
    double x, double y, double dx, double dy) {}

  void onUnattach() {}

  void unattach() {
    onUnattach();
    for (DisplayObject d in child) {
      d.unattach();
    }
  }
}
