part of tinygame_webgl;

class TinyGameBuilderForWebgl extends TinyGameBuilder {
  int width = 600.0 + 100.0;
  int height = 400.0 + 100.0;
  TinyStage createStage(TinyDisplayObject root) {
    return new TinyWebglStage(this, root);
  }

  Future<TinyImage> loadImageBase(String path) async {
    return null;
  }
}

class TinyWebglStage extends Object with TinyStage {
  double _widht;
  double _height;
  double get x => 0.0;
  double get y => 0.0;
  double get w => _widht;
  double get h => _height;

  double get paddingTop => 0.0;
  double get paddingBottom => 0.0;
  double get paddingRight => 0.0;
  double get paddingLeft => 0.0;

  bool animeIsStart = false;
  int animeId = 0;
  TinyDisplayObject _root;
  TinyDisplayObject get root => _root;

  TinyGameBuilder _builder;
  TinyGameBuilder get builder => _builder;

  CanvasElement _canvasElement;
  RenderingContext GL;
  TinyWebglStage(this._builder, this._root,{width:600.0,height:400.0}) {
    print("--------new stage");

    _widht = width;
    _height = height;
    _canvasElement =  //new CanvasElement(width: 500, height: 500);//
    new CanvasElement(width:_widht.toInt(), height:_height.toInt());
    document.body.append(_canvasElement);
    GL = _canvasElement.getContext3d();
    double r = 0.0;
    double g = 0.0;
    double b = 0.0;
    double a = 1.0;
    GL.clearColor(r, g, b, a);
    GL.clear(RenderingContext.COLOR_BUFFER_BIT);

  }

  void init()  {
  }

  void start() {
  }

  void stop() {
    if (animeIsStart == true) {
      scheduler.cancelAnimationFrame(animeId);
    }
    animeIsStart = false;
  }

}

class TinyWebglCanvas extends TinyCanvas {
  TinyWebglCanvas() {}

  void drawOval(TinyStage stage, TinyRect rect, TinyPaint paint) {
  }
  void drawLine(TinyStage stage, TinyPoint p1, TinyPoint p2, TinyPaint paint) {

  }

  void drawRect(TinyStage stage, TinyRect rect, TinyPaint paint) {

  }

  void clipRect(TinyStage stage, TinyRect rect) {
  }

  void drawImageRect(
      TinyStage stage, TinyImage image, TinyRect src,
      TinyRect dst, TinyPaint paint) {
  }

  void updateMatrix() {
  }
}