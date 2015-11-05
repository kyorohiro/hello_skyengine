import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:ch48/tinygame.dart';
import 'package:ch48/tinygame_flutter.dart';
import 'glogic/glogic.dart';
//import 'test/test001.dart' as t001;
//import 'test/test002.dart' as t002;
//import 'test/test003.dart' as t003;
bool isTestMode = false;
//bool isTestMode = true;
void main() {
  if(isTestMode == false) {
    Game game = new Game(new TinyGameBuilderForFlutter("web/"));
    runApp(new GameWidget(game));
  } else {
//    t001.main();
//    t002.main();
//    t003.main();
  }
}

class GameWidget extends OneChildRenderObjectWidget {
  Game game;
  GameWidget(this.game) {}
  RenderObject createRenderObject() {
    game.stage.start();
    game.stage.root.child.add(game.startScene);
    return (game.stage as TinyFlutterStage);
  }
}
