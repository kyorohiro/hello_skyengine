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

  clearChild() async {
    await new Future.value();
    for(TinyDisplayObject d in child) {
      rmChild(d);
    }
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
    connectCheck();
    onTick(stage, timeStamp);
    for (TinyDisplayObject d in child) {
      d.tick(stage, timeStamp);
    }
  }

  void onPaint(TinyStage stage, TinyCanvas canvas) {
    ;
  }

  void paint(TinyStage stage, TinyCanvas canvas) {
    connectCheck();
    onPaint(stage, canvas);
    for (TinyDisplayObject d in child) {
      canvas.pushMulMatrix(d.mat);
      d.paint(stage, canvas);
      canvas.popMatrix();
    }
  }

  void touch(TinyStage stage, int id, String type, double x, double y) {
    connectCheck();
    {
      Matrix4 tmp = stage.getMatrix().clone();
      tmp.invert();
      Vector3 a = tmp * new Vector3(x, y, 0.0);
      onTouch(stage, id, type, a.x, a.y, x, y);
    }
    for (TinyDisplayObject d in child) {
      stage.pushMulMatrix(d.mat);
      d.touch(stage, id, type, x, y);
      stage.popMatrix();
    }
  }

  void onTouch(TinyStage stage, int id, String type, double x, double y, double globalX, globalY) {}

  void onUnattach() {}

  void unattach() {
    onUnattach();
    for (TinyDisplayObject d in child) {
      d.unattach();
    }
    isConnect = false;
  }

  void onConnect() {}

  connectCheck() {
    if(isConnect == false) {
      isConnect = true;
      onConnect();
    }

  }
  bool isConnect = false;
}
