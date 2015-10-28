import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'tinygame.dart';
import 'dart:math' as math;
import 'dart:async';
import 'package:flutter/services.dart';
import 'playscene.dart';
import 'programscene.dart';
import 'main.dart';
import 'glogic/game.dart';

class PlayChara extends TinyDisplayObject {
  Game game;
  TinyImage img = null;
  GameTargetSource target;

  void onConnect() {
    target.angle = 0.0;
    target.dx = 0.0;
    target.dy = 0.0;
    target.x = 100.0;
    target.y = 300.0;
  }

  PlayChara(this.game) {
    target = new GameTargetSource(this.game, 50.0);
    game.f.loadImage("assets/ch_iron.png").then((TinyImage i) {
      img = i;
    });
  }

  void onPaint(TinyStage stage, TinyCanvas canvas) {
    TinyRect src = new TinyRect(0.0, 0.0, img.w.toDouble(), img.h.toDouble());
    TinyRect dst = new TinyRect(-50.0, -50.0, 100.0, 100.0);
    TinyPaint p = new TinyPaint();
    if (img != null) {
      canvas.drawImageRect(stage, img, src, dst, p);
    }
  }

  void onTick(TinyStage stage, int timeStamp) {
    game.programRed.next(new GameEnvirone(), this.target);
    this.target.next();
    mat = new Matrix4.identity();
    mat.translate(this.target.x, this.target.y,1.0);
    mat.rotateZ(this.target.angle);
  }

  void advance(double speed) {
    this.target.advance(speed);
  }

  void turn(double a) {
    this.target.advance(a);
  }
}
