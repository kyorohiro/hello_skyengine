import 'package:sky/widgets.dart';
import 'package:sky/rendering.dart';
import 'spacewar.dart';

void main() {
  runApp(new DrawRectWidget());
}

class DrawRectWidget extends OneChildRenderObjectWidget {
  RenderObject createRenderObject() {
    Stage stage = new Stage(new Logic());
    stage.start();
    return stage;
  }
}
