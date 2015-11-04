part of tinygame_webgl;

class TinyGameBuilderForWebgl extends TinyGameBuilder {
  int width = 600 + 100;
  int height = 400 + 100;
  TinyStage createStage(TinyDisplayObject root) {
    return new TinyWebglStage(this, root);
  }

  Future<TinyImage> loadImageBase(String path) async {
    ImageElement elm = await TinyWebglLoader.loadImage(path);
    return new TinyWebglImage(elm);
  }
}
class TinyWebglImage extends TinyImage {
  int get w=> elm.width;
  int get h=> elm.height;
  ImageElement elm;
  TinyWebglImage(this.elm){;}
  
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

  TinyWebglStage(this._builder, TinyDisplayObject root,
      {width: 600.0, height: 400.0}) {
    print("--------new stage");
    glContext = new TinyWebglContext(width: width, height: height);
    this.root = root;
  }

  bool isPaint = false;
  void markNeedsPaint() {
    isPaint = true;
  }

  void init() {}

  void start() {
    if (animeIsStart == false) {
      animeIsStart = true;
      _anime();
    }
  }

  Future _anime() async {
    num startTime = new DateTime.now().millisecond;
    while (animeIsStart) {
      await new Future.delayed(new Duration(milliseconds: 20));
      num currentTime = new DateTime.now().millisecond;
      kick(currentTime - startTime);
      markNeedsPaint();
      if (isPaint) {
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
  TinyWebglContext({width: 600.0, height: 400.0}) {
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
    init();
    clear();
  }
  Program programShape;
  Program programImage;
  void init() {
    {
      String vs = [
        "attribute vec3 vp;",
        "uniform mat4 u_mat;",
        "void main() {",
        "  gl_Position = u_mat*vec4(vp.x,vp.y,vp.z,1.0);",
        "}"
      ].join("\n");
      String fs = [
        "precision mediump float;",
        "uniform vec4 color;",
        "void main() {",
        "",
        " gl_FragColor = color;",
        "}"
      ].join("\n");
      programShape = TinyWebglProgram.compile(GL, vs, fs);
    }
    {
      String vs = [
        "attribute vec3 vp;",
        "attribute vec2 a_tex;",
        "varying vec2 v_tex;",
        "void main() {",
        "  gl_Position = vec4(vp, 1.0);",
        "  v_tex = a_tex;",
        "}"
      ].join("\n");
      String fs = [
        "precision mediump float;",
        "varying vec2 v_tex;",
        "uniform sampler2D u_image;",
        "uniform vec4 color;",
        "void main() {",
        " gl_FragColor = texture2D(u_image, v_tex);",
        "}"
      ].join("\n");
      programImage = TinyWebglProgram.compile(GL, vs, fs);
    }
  }

  void clear() {
    double r = 0.0;
    double g = 0.0;
    double b = 0.0;
    double a = 1.0;
    GL.clearColor(r, g, b, a);
    GL.clear(RenderingContext.COLOR_BUFFER_BIT);
  }

  void drawOval(TinyStage stage, TinyRect rect, TinyPaint paint) {}

  void drawLine(TinyStage stage, TinyPoint p1, TinyPoint p2, TinyPaint paint) {}

 Matrix4 calcMat() {
   Matrix4 m = new Matrix4.identity();
   m = m.translate(-1.0, 1.0, 0.0);
   m = m.scale(2.0/glContext.widht, -2.0/glContext.height,1.0);
   m = m* getMatrix();
   return m;
 }

 void drawRect(TinyStage stage, TinyRect rect, TinyPaint paint) {
    print("---drawRect");
    //
    //
    GL.useProgram(programShape);
    
    //
    // vertex
    // 
    double sx = rect.x;
    double sy = rect.y;
    double ex = rect.x+rect.w;
    double ey = rect.y+rect.h;
    Buffer rectBuffer = TinyWebglProgram.createArrayBuffer(GL, [sx, sy, 0.0, sx, ey, 0.0, ex, sy, 0.0, ex, ey, 0.0]);
    GL.bindBuffer(RenderingContext.ARRAY_BUFFER, rectBuffer);

    Buffer rectIndexBuffer = TinyWebglProgram.createElementArrayBuffer(GL, [0, 1, 2, 1, 3, 2]);
    GL.bindBuffer(RenderingContext.ELEMENT_ARRAY_BUFFER, rectIndexBuffer);


    //
    // draw
    {
      int locationVertexPosition = GL.getAttribLocation(programShape, "vp");
      UniformLocation locationMat = GL.getUniformLocation(programShape, "u_mat");

      GL.uniformMatrix4fv(locationMat, false, new Float32List.fromList(calcMat().storage));
      GL.vertexAttribPointer(
          locationVertexPosition, 3, RenderingContext.FLOAT, false, 0, 0);
      var colorLocation = GL.getUniformLocation(programShape, "color");
      GL.uniform4f(colorLocation, paint.color.rf, paint.color.gf,
          paint.color.bf, paint.color.af);
      GL.enableVertexAttribArray(locationVertexPosition);
      GL.drawElements(
          RenderingContext.TRIANGLES, 6, RenderingContext.UNSIGNED_SHORT, 0);
    }
    GL.useProgram(null);
  }

  void clipRect(TinyStage stage, TinyRect rect) {
    
  }

  void drawImageRect(TinyStage stage, TinyImage image, TinyRect src,
      TinyRect dst, TinyPaint paint) {
    TinyWebglImage img = image;
    print("---drawRect");
    //
    //
    GL.useProgram(programImage);
    int texLocation = GL.getAttribLocation(programImage, "a_tex");
    Buffer texBuffer = GL.createBuffer();
    GL.bindBuffer(RenderingContext.ARRAY_BUFFER, texBuffer);
    GL.bufferData(RenderingContext.ARRAY_BUFFER, 
        new Float32List.fromList([
          0.0, 0.0, 
          0.0, 1.0, 
          1.0, 0.0, 
          1.0, 1.0]),         
        RenderingContext.STATIC_DRAW);
    GL.enableVertexAttribArray(texLocation);
    GL.vertexAttribPointer(texLocation, 2, RenderingContext.FLOAT, false, 0,0);
    //
    Texture tex = GL.createTexture();    
    GL.bindTexture(RenderingContext.TEXTURE_2D, tex);
    //
    GL.texParameteri(RenderingContext.TEXTURE_2D, 
        RenderingContext.TEXTURE_WRAP_S, RenderingContext.CLAMP_TO_EDGE);
    GL.texParameteri(RenderingContext.TEXTURE_2D, 
        RenderingContext.TEXTURE_WRAP_T, RenderingContext.CLAMP_TO_EDGE);
    GL.texParameteri(RenderingContext.TEXTURE_2D,
        RenderingContext.TEXTURE_MIN_FILTER, RenderingContext.NEAREST);
    GL.texParameteri(RenderingContext.TEXTURE_2D, 
        RenderingContext.TEXTURE_MAG_FILTER, RenderingContext.NEAREST);
    //
    GL.texImage2D(RenderingContext.TEXTURE_2D, 0, 
        RenderingContext.RGBA, 
        RenderingContext.RGBA, RenderingContext.UNSIGNED_BYTE, img.elm);
    double sx = -1.0 + 2.0 * dst.x / glContext.widht;
    double sy = 1.0 - 2.0 * dst.y / glContext.height;
    double ex = sx + 2.0 * dst.w / glContext.widht;
    double ey = sy - 2.0 * dst.h / glContext.height;
    TypedData rectData = new Float32List.fromList(
        [sx, sy, 0.0, sx, ey, 0.0, ex, sy, 0.0, ex, ey, 0.0]);
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
      int locationVertexPosition = GL.getAttribLocation(programImage, "vp");
      GL.vertexAttribPointer(
          locationVertexPosition, 3, RenderingContext.FLOAT, false, 0, 0);
      var colorLocation = GL.getUniformLocation(programImage, "color");
      GL.uniform4f(colorLocation, paint.color.rf, paint.color.gf,
          paint.color.bf, paint.color.af);
      GL.enableVertexAttribArray(locationVertexPosition);
      GL.drawElements(
          RenderingContext.TRIANGLES, 6, RenderingContext.UNSIGNED_SHORT, 0);
    }
  }

  void updateMatrix() {}
}
