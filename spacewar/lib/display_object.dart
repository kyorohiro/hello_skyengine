part of spacewar;
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
    if(this.objectName == objectName) {
      return this;
    }
    for(DisplayObject d in child) {
      DisplayObject t = d.fincObjectFromObjectName(objectName);
      if(t != null) {
        return t;
      }
    }
    return null;
  }

  void onInit(Stage stage) {

  }

  void init(Stage stage) {
    onInit(stage);
    for (DisplayObject d in child) {
      d.init(stage);
    }
  }

  void onTick(Stage stage, double timeStamp) {

  }

  void tick(Stage stage, double timeStamp) {
    onTick(stage, timeStamp);
    for (DisplayObject d in child) {
      d.onTick(stage, timeStamp);
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
}
