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
import '../glogic/game.dart';
import '../glogic/target.dart';
import '../glogic/env.dart';

class GameProgram {
  GameTip startTip;
  GameTip currentTip;
  List<GameTip> raw;
  int w;
  int h;

  GameProgram(this.w, this.h) {
    raw = new List.filled(w*h, new GameTip.empty());
    for(int i=0;i<w;i++) {
      setTip(i, 0, new GameTip.frame());
      setTip(i, h-1, new GameTip.frame());
    }
    for(int i=0;i<h;i++) {
      setTip(0, i, new GameTip.frame());
      setTip(w-1, i, new GameTip.frame());
    }
    startTip = new GameTip.start();
    currentTip = startTip;
    setTip(1, 0, startTip);
  }

  void next(GameEnvirone e, GameTarget t) {
     currentTip = currentTip.next(this, e, t);
  }

  GameTip getTip(int x, int y) {
    return raw[x+y*w];
  }

  void setTip(int x, int y, GameTip v) {
    raw[x+y*w] = v;
    v.curX = x;
    v.curY = y;
  }
}
