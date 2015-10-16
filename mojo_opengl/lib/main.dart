import 'package:flutter/widgets.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:mojo_services/mojo/gpu.mojom.dart' as gpu;
import 'package:mojo_services/mojo/gpu_capabilities.mojom.dart' as gpuc;
import 'package:mojo_services/mojo/surfaces.mojom.dart' as surface;

main() async {
//  gpu.GpuProxy proxy = new gpu.GpuProxy.unbound();
//  proxy.ptr.createOffscreenGleS2Context(gles2Client);

//  print();
//  _deviceInfo.close();
  runApp(new DrawRectWidget());
}

class DrawRectWidget extends OneChildRenderObjectWidget {
  RenderObject createRenderObject() {
    return new DrawRectObject();
  }
}

class DrawRectObject extends RenderBox {
  void paint(PaintingContext context, Offset offset) {
    Paint p = new Paint();
    p.color = new Color.fromARGB(0xff, 0xff, 0xff, 0xff);
    Rect r = new Rect.fromLTWH(50.0, 100.0, 150.0, 25.0);
    context.canvas.drawRect(r, p);
  }
}
