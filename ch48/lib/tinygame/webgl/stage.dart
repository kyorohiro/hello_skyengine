part of tinygame_webgl;

class TinyGameBuilderForWebgl extends TinyGameBuilder {
  int width = 600 + 100;
  int height = 400 + 100;
  TinyStage createStage(TinyDisplayObject root) {
    return new TinyWebglStage(this, root);
  }

  Future<TinyImage> loadImageBase(String path) async {
    return null;
  }
}

class TinyWebglStage extends Object with TinyStage {

  TinyWebglContext glContext;
  double get x => 0.0;
  double get y => 0.0;
  double get w => glContext.widht;
  double get h => glContext.height;

  double get paddingTop => 0.0;
  double get paddingBottom => 0.0;
  double get paddingRight => 0.0;
  double get paddingLeft => 0.0;

  bool animeIsStart = false;
  int animeId = 0;

  TinyGameBuilder _builder;
  TinyGameBuilder get builder => _builder;



  TinyWebglStage(this._builder, TinyDisplayObject root,{width:600.0,height:400.0}) {
    print("--------new stage");
    glContext = new TinyWebglContext(width:width, height:height);
    this.root = root;
  }

  bool isPaint = false;
  void markNeedsPaint() {
    isPaint = true;
  }
  void init()  {
  }

  void start() {
    if(animeIsStart == false) {
      animeIsStart = true;
      _anime();
    }
  }

  Future _anime() async {
    num startTime = new DateTime.now().millisecond;
    while (animeIsStart) {
      await new Future.delayed(new Duration(milliseconds: 20));
      num currentTime = new DateTime.now().millisecond;
      kick(currentTime-startTime);
      markNeedsPaint();
      if(isPaint) {
        root.paint(this, new TinyWebglCanvas(glContext));
      }
      isPaint = false;
    }
  }

  void stop() {
    animeIsStart = false;
  }

}

class TinyWebglContext {
  RenderingContext GL;
  CanvasElement _canvasElement;
  double widht;
  double height;
  TinyWebglContext({width:600.0,height:400.0}) {
    this.widht = width;
    this.height = height;
    _canvasElement = //new CanvasElement(width: 500, height: 500);//
    new CanvasElement(width: widht.toInt(), height: height.toInt());
    document.body.append(_canvasElement);
    GL = _canvasElement.getContext3d();
  }
}

class TinyWebglCanvas extends TinyCanvas {
  RenderingContext GL;
  TinyWebglContext glContext;
  TinyWebglCanvas(TinyWebglContext c) {
    GL = c.GL;
    glContext = c;
    clear();
  }

  void clear() {
    double r = 0.0;
    double g = 0.0;
    double b = 0.0;
    double a = 1.0;
    GL.clearColor(r, g, b, a);
    GL.clear(RenderingContext.COLOR_BUFFER_BIT);
  }
  
  
  void drawOval(TinyStage stage, TinyRect rect, TinyPaint paint) {
  }

  void drawLine(TinyStage stage, TinyPoint p1, TinyPoint p2, TinyPaint paint) {

  }

  void drawRect(TinyStage stage, TinyRect rect, TinyPaint paint) {
    print("---drawRect");
    String vs = [
      "attribute vec3 vp;",
      "void main() {",
      "  gl_Position = vec4(vp, 1.0);",
      "}"
    ].join("\n");
    String fs = [
      "precision mediump float;",
      "uniform vec4 u_color;",
      "void main() {",
      " gl_FragColor = u_color;",
      "}"
    ].join("\n");
    Program p = TinyWebglProgram.compile(GL, vs, fs);
    GL.useProgram(p);
    //
    //

    double sx = -1.0+2.0*rect.x/glContext.widht;
    double sy = 1.0-2.0*rect.y/glContext.height;
    double ex = sx+2.0*rect.w/glContext.widht;
    double ey = sy-2.0*rect.h/glContext.height;
    TypedData rectData = new Float32List.fromList(
        [ sx, sy, 0.0,
          sx, ey, 0.0,
          ex, sy, 0.0,
          ex, ey, 0.0]);
    TypedData rectDataIndex = new Uint16List.fromList([0, 1, 2, 1, 3, 2]);

    Buffer rectBuffer = GL.createBuffer();
    GL.bindBuffer(RenderingContext.ARRAY_BUFFER, rectBuffer);
    GL.bufferData(ARRAY_BUFFER, rectData, RenderingContext.STATIC_DRAW);

    Buffer rectIndexBuffer = GL.createBuffer();
    GL.bindBuffer(ELEMENT_ARRAY_BUFFER, rectIndexBuffer);
    GL.bufferDataTyped(RenderingContext.ELEMENT_ARRAY_BUFFER, rectDataIndex,
        RenderingContext.STATIC_DRAW);

    //
    // draw

     {
      int locationVertexPosition = GL.getAttribLocation(p, "vp");
      GL.vertexAttribPointer(
          locationVertexPosition, 3, RenderingContext.FLOAT, false, 0, 0);
      var colorLocation = GL.getUniformLocation(p, "u_color");
      GL.uniform4f(colorLocation, 1.0, 1.0, 0.0, 0.5);  
      GL.enableVertexAttribArray(locationVertexPosition);
      GL.drawElements(
          RenderingContext.TRIANGLES, 6, RenderingContext.UNSIGNED_SHORT, 0);
    }


  }

  void clipRect(TinyStage stage, TinyRect rect) {
  }

  void drawImageRect(TinyStage stage, TinyImage image, TinyRect src,
      TinyRect dst, TinyPaint paint) {

  }

  void updateMatrix() {
  }
}
