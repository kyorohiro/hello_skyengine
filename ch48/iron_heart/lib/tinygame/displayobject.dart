part of tinygame;

class TinyDisplayObject {
  String objectName = "none";
  List<TinyDisplayObject> child = [];
  Matrix4 mat = new Matrix4.identity();

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
      canvas.pushMulMatrix(d.mat);
      d.paint(stage, canvas);
      canvas.popMatrix();
    }
  }

  void touch(TinyStage stage, int id, String type, double x, double y) {
    {
      Matrix4 tmp = stage.getMatrix().clone();
      tmp.invert();
      Vector3 a = tmp * new Vector3(x, y, 0.0);
      onTouch(stage, id, type, a.x, a.y);
    }
    for (TinyDisplayObject d in child) {
      stage.pushMulMatrix(d.mat);
      d.touch(stage, id, type, x, y);
      stage.popMatrix();
    }
  }

  void onTouch(TinyStage stage, int id, String type, double x, double y) {}

  void onUnattach() {}

  void unattach() {
    onUnattach();
    for (TinyDisplayObject d in child) {
      d.unattach();
    }
  }
}
