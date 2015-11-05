part of tinygame_webgl;

class TinyWebglLoader {

  static Future<ImageElement> loadImage(String path) async {
    Completer<ImageElement> c = new Completer();
    ImageElement elm = new ImageElement(src:path);
    elm.onLoad.listen((_){c.complete(elm);});
    elm.onError.listen((_){c.completeError("failed to load image ${path}");});
    return c.future;
  }

  static Future<String> loadString(String path) async {
    return await HttpRequest.getString(path);
  }

}


class TinyWebglProgram {

  static Program compile(RenderingContext GL, String vs, String fs) {
    // setup shader
    Shader vertexShader = loadShader(
        GL, RenderingContext.VERTEX_SHADER, vs);

    Shader fragmentShader = loadShader(
        GL, RenderingContext.FRAGMENT_SHADER, fs);

    Program shaderProgram = GL.createProgram();
    GL.attachShader(shaderProgram, fragmentShader);
    GL.attachShader(shaderProgram, vertexShader);
    GL.linkProgram(shaderProgram);
    //
    //     GL.useProgram(shaderProgram);
    return shaderProgram;
  }

  static Shader loadShader(RenderingContext context, int type, var src) {
    Shader shader = context.createShader(type);
    context.shaderSource(shader, src);
    context.compileShader(shader);
    if (false == context.getShaderParameter(shader, RenderingContext.COMPILE_STATUS)) {
      String message = "Error compiling shader ${context.getShaderInfoLog(shader)}";
      context.deleteShader(shader);
      throw "${message}\n";
    }
    return shader;
  }

  static Buffer createArrayBuffer(RenderingContext context, List data) {
    Buffer ret = context.createBuffer();
    context.bindBuffer(RenderingContext.ARRAY_BUFFER, ret);
    context.bufferData(RenderingContext.ARRAY_BUFFER, 
        new Float32List.fromList(data), RenderingContext.STATIC_DRAW);
    context.bindBuffer(RenderingContext.ARRAY_BUFFER, null);
    return ret;
  }
  
  static Buffer createElementArrayBuffer(RenderingContext context, List data) {
    Buffer ret = context.createBuffer();
    context.bindBuffer(RenderingContext.ELEMENT_ARRAY_BUFFER, ret);
    context.bufferDataTyped(RenderingContext.ELEMENT_ARRAY_BUFFER, new Uint16List.fromList(data),
        RenderingContext.STATIC_DRAW);
    context.bindBuffer(RenderingContext.ELEMENT_ARRAY_BUFFER, null);
    return ret;
  }
  
  static setUniformF(RenderingContext context, Program program, String name, double v) {
    var location = context.getUniformLocation(program, name);
    context.uniform1f(location, v);
  }

  static setUniformVec4(RenderingContext context, Program program, String name, List v) {
    var location = context.getUniformLocation(program, name);
    context.uniform4fv(location, new Float32List.fromList(v));
  }
  
  static setUniformMat4(RenderingContext context, Program program, String name, Matrix4 v) {
    var location = context.getUniformLocation(program, name);
    context.uniformMatrix4fv(location, false, new Float32List.fromList(v.storage));
  }
  
}