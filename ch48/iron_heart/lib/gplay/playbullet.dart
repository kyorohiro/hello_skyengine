import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import '../tinygame.dart';
import '../glogic/game.dart';
import '../glogic/target.dart';

class PlayBullet extends TinyDisplayObject {
  Game game;
  GameTargetSource target;

  PlayBullet(this.game, this.target) {
  }

  void onPaint(TinyStage stage, TinyCanvas canvas) {
    TinyRect dst = new TinyRect(-50.0, -50.0, 100.0, 100.0);
    TinyPaint p = new TinyPaint();
    canvas.drawOval(stage, dst, p);
  }

  void onTick(TinyStage stage, int timeStamp) {
    mat = new Matrix4.identity();
    mat.translate(this.target.x, this.target.y, 1.0);
    mat.rotateZ(this.target.angle);
  }

  void advance(double speed) {
    this.target.advance(speed);
  }

  void turn(double a) {
    this.target.advance(a);
  }
}
