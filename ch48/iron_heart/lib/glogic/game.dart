import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import '../tinygame.dart';
import 'dart:math' as math;
import 'dart:async';
import 'package:flutter/services.dart';
import '../playscene.dart';
import '../programscene.dart';
import '../main.dart';
import '../glogic/tip.dart';
import '../glogic/program.dart';

class Game {
  TinyGameBuilderForFlutter f;
  PlayScene playScene;
  StartScreen startScene;
  ProgramScree progScene;
  TinyStage stage;
  GameProgram programRed;
  GameTarget targetRed;
  GameProgram programBlue;
  GameTarget targetBlue;
  double fieldX = 50.0;
  double fieldY = 50.0;
  double fieldWidth = 700.0;
  double fieldHeight = 500.0;

  Game() {
    programRed = new GameProgram(10, 7);
    programBlue = new GameProgram(10, 7);
    targetRed = new GameTargetSource(this, 50.0);
    targetBlue = new GameTargetSource(this, 50.0);

    f = new TinyGameBuilderForFlutter();
    playScene = new PlayScene(this);
    startScene = new StartScreen(this);
    progScene = new ProgramScree(this);
    stage = f.createStage(new TinyGameRoot(800.0, 600.0));

  }
}


class GameEnvirone {

}

class GameTargetSource extends GameTarget {
  double angle = 0.0;
  double dx = 0.0;
  double dy = 0.0;
  double x = 0.0;
  double y = 0.0;
  //radius
  double size;
  Game game;

  GameTargetSource(this.game, this.size) {
    ;
  }

  void next() {
    x +=dx;
    y +=dy;
    if(game.fieldX > x-size) {
      x = game.fieldX + size;
    }
    if(game.fieldX + game.fieldWidth < x+size) {
      x = game.fieldX + game.fieldWidth - size;
    }

    if(game.fieldY > y-size) {
      y = game.fieldY + size;
    }
    if(game.fieldY + game.fieldHeight < y+size) {
      y = game.fieldY + game.fieldHeight - size;
    }
  }

  void advance(double speed) {
    dx = speed*math.cos(angle);
    dy = speed*math.sin(angle);
  }

  void turn(double a) {
    angle += a;
  }
}


abstract class GameTarget {
  double angle = 0.0;
  double dx = 0.0;
  double dy = 0.0;
  double x = 0.0;
  double y = 0.0;
  void advance(double speed);
  void turn(double a);
}
