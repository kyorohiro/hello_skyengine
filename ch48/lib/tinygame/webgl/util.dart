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

  static compile(RenderingContext GL, String vs, String fs) {
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
}