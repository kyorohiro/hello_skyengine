import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import '../tinygame.dart';
import 'dart:math' as math;
import '../glogic/game.dart';
import '../glogic/tip.dart';

import './tipselect.dart';

class ProgramScree extends TinyDisplayObject {
  Game game;
  TinyImage bgImg = null;
  TipSelect tipSelect;

  ProgramScree(this.game) {
    game.f.loadImage("assets/bg_prog.png").then((TinyImage i) {
      bgImg = i;
    });
    {
      child.add(newBackButton());
      child.add(newSelectButton());
      child.add(newYesButton());
      child.add(newNoButton());
    }
    tipSelect = new TipSelect(game.f, this, selectTipX, selectTipY, selectTip);
  }
  void selectTip(String id) {
    GameTip tip = id2Tip(id);
    if(tip != null) {
      game.environ.targetRed.program.setTip(selectTipX, selectTipY, tip);
    }
  }

  GameTip id2Tip(String id) {
    print("-------------${id}");
    GameTip tip = null;
    switch(id) {
    case TipSelect.actFront:
      tip = new GameTip.front();
      break;
    case TipSelect.actRight:
      tip = new GameTip.right();
      break;
    case TipSelect.actLeft:
      tip = new GameTip.left();
      break;
    case TipSelect.actBack:
      tip = new GameTip.back();
      break;
    case TipSelect.actRotateRight:
      tip = new GameTip.turningRight();
      break;
    case TipSelect.actRotateLeft:
      tip = new GameTip.turningLeft();
      break;
      case TipSelect.actShoot:
        tip = new GameTip.shoot();
        break;
    }
    return tip;
  }

  String id2Path(String id) {
    print("-------------${id}");
    return id;
  }

  String tipID2Path(int id) {
    switch(id) {
      case GameTip.id_empty:
      case GameTip.id_frame:
      case GameTip.id_start:
      case GameTip.id_nop:
      case GameTip.id_search_enemy:
      return null;
      case GameTip.id_front:
        return TipSelect.actFront;
      case GameTip.id_right:
        return  TipSelect.actRight;
      case GameTip.id_left:
        return  TipSelect.actLeft;
      case GameTip.id_back:
        return TipSelect.actBack;
      case GameTip.id_turning_right:
        return TipSelect.actRotateRight;
      case GameTip.id_turning_left:
        return TipSelect.actRotateLeft;
      case GameTip.id_shoot:id:
        return TipSelect.actShoot;
      }
    return null;
  }

  TinyDisplayObject newBackButton() {
    TinyButton button = new TinyButton("back_button", 200.0, 120.0, onPush);
    button.mat = new Matrix4.translationValues(30.0, 480.0, 0.0);
    button.bgcolorOn = new TinyColor.argb(0x22, 0xFF, 0x00, 0x00);
    button.bgcolorOff = new TinyColor.argb(0x00, 0x00, 0x00, 0xff);
    button.bgcolorFocus = new TinyColor.argb(0x11, 0x00, 0xff, 0x00);
    return button;
  }

  TinyDisplayObject newSelectButton() {
    TinyImageButton button = new TinyImageButton(game.f, "select_button", "assets/con_sel.png", 80.0, 80.0, onPush);
//    TinyButton button = new TinyButton("select_button", 80.0, 80.0, onPush);
    button.mat = new Matrix4.translationValues(500.0, 500.0, 0.0);
    button.bgcolorOn = new TinyColor.argb(0x22, 0xFF, 0x00, 0x00);
    button.bgcolorOff = new TinyColor.argb(0xff, 0xff, 0xff, 0xff);
    button.bgcolorFocus = new TinyColor.argb(0x11, 0x00, 0xff, 0x00);
    return button;
  }

  TinyDisplayObject newYesButton() {
    TinyImageButton button = new TinyImageButton(game.f, "yes_button", "assets/con_yes_rot.png", 80.0, 80.0, onPush);
    //TinyButton button = new TinyButton("yes_button", 80.0, 80.0, onPush);
    button.mat = new Matrix4.translationValues(600.0, 500.0, 0.0);
    button.bgcolorOn = new TinyColor.argb(0x22, 0xFF, 0x00, 0x00);
    button.bgcolorOff = new TinyColor.argb(0xff, 0xff, 0xff, 0xff);
    button.bgcolorFocus = new TinyColor.argb(0x11, 0x00, 0xff, 0x00);
    return button;
  }

  TinyDisplayObject newNoButton() {
    TinyImageButton button = new TinyImageButton(game.f, "no_button", "assets/con_no_rot.png", 80.0, 80.0, onPush);
  //  TinyButton button = new TinyButton("no_button", 80.0, 80.0, onPush);
    button.mat = new Matrix4.translationValues(700.0, 500.0, 0.0);
    button.bgcolorOn = new TinyColor.argb(0x22, 0xFF, 0x00, 0x00);
    button.bgcolorOff = new TinyColor.argb(0xff, 0xff, 0xff, 0xff);
    button.bgcolorFocus = new TinyColor.argb(0x11, 0x00, 0xff, 0x00);
    return button;
  }

  void onPaint(TinyStage stage, TinyCanvas canvas) {
    drawBG(stage, canvas);
    drawTips(stage, canvas);
  }

  void drawBG(TinyStage stage, TinyCanvas canvas) {
    if (bgImg != null) {
      TinyRect src =
          new TinyRect(0.0, 0.0, bgImg.w.toDouble(), bgImg.h.toDouble());
      TinyRect dst = new TinyRect(0.0, 0.0, 800.0, 600.0);
      TinyPaint p = new TinyPaint();
      canvas.drawImageRect(stage, bgImg, src, dst, p);
    }
  }

  int selectTipX = 1;
  int selectTipY = 1;
  bool onTouch(TinyStage stage, int id, String type, double x, double y,
      double globalX, globalY) {
    //print("###### x=${x}   y=${y}");
    double x1 = x - 50.0;
    double y1 = y - 5.0;
    double xx = x1 / (50 + 20);
    double yy = y1 / (50 + 20);
    //print("###### x:y=${xx}:${yy}   x=${x}   y=${y}");

    //
    if (!child.contains(tipSelect)) {
      int _tmpX = xx.toInt();
      int _tmpY = yy.toInt();
      if (0 < _tmpX && _tmpX < game.environ.targetRed.program.w - 1) {
        if (0 < _tmpY && _tmpY < game.environ.targetRed.program.h - 1) {
          selectTipX = xx.toInt();
          selectTipY = yy.toInt();
        }
      }
    }
    return false;
  }

  void drawTips(TinyStage stage, TinyCanvas canvas) {
    for (int y = 0; y < game.environ.targetRed.program.h; y++) {
      for (int x = 0; x < game.environ.targetRed.program.w; x++) {
        drawTip(stage, canvas, x, y);
      }
    }
  }

  void drawTip(TinyStage stage, TinyCanvas canvas, int x, int y) {
    TinyPaint p = new TinyPaint();
    p.strokeWidth = 2.5;
    p.style = TinyPaintStyle.stroke;
    double xx = 50.0 + x * (50 + 20);
    double yy = 5.0 + y * (50 + 20);
    double ww = 50.0;
    double hh = 50.0;
    TinyRect rect = new TinyRect(xx, yy, ww, hh);
    GameTip tip = game.environ.targetRed.program.getTip(x, y);
    p.color = new TinyColor(tip.id);

    if (x == selectTipX && y == selectTipY) {
      p.style = TinyPaintStyle.stroke;
      p.strokeWidth = 10.5;
    } else {
      p.style = TinyPaintStyle.stroke;
      p.strokeWidth = 2.5;
    }
    {
      canvas.drawRect(stage, rect, p);
    }
    {
      String path = tipID2Path(tip.id);
      TinyImage img = null;
      if(path != null) {
        img = game.f.getImage(path);
      }
      if(img != null) {
        TinyRect src = new TinyRect(0.0,0.0, img.w.toDouble(), img.h.toDouble());
        canvas.drawImageRect(stage, img, src, rect, p);
      }
    }
    for (Next n in tip.dxys) {
      double angle = 0.0;
      if (n.dx == 1 && n.dy == 0) {
        angle = 0.0;
      }
      if (n.dx == 1 && n.dy == 1) {
        angle = 45.0;
      }
      if (n.dx == 0 && n.dy == 1) {
        angle = 90.0;
      }
      if (n.dx == -1 && n.dy == 1) {
        angle = 135.0;
      }
      if (n.dx == -1 && n.dy == 0) {
        angle = 180.0;
      }
      if (n.dx == -1 && n.dy == -1) {
        angle = 215.0;
      }
      if (n.dx == 0 && n.dy == -1) {
        angle = 260.0;
      }
      if (n.dx == 1 && n.dy == -1) {
        angle = 315.0;
      }
      drawArrow(stage, canvas, x, y, math.PI * 2.0 * ((angle - 90.0) / 360.0));
    }
  }

  void drawArrow(
      TinyStage stage, TinyCanvas canvas, int x, int y, double angle) {
    TinyPaint p = new TinyPaint();
    p.strokeWidth = 2.5;
    p.style = TinyPaintStyle.stroke;
    p.color = new TinyColor(game.environ.targetRed.program.getTip(x, y).id);

    double xx = 50.0 + x * (50 + 20);
    double yy = 5.0 + y * (50 + 20);
    double ww = 50.0;
    double hh = 50.0;

    //
    // allow
    TinyPoint p1 = new TinyPoint(-10.0, 0.0);
    TinyPoint p2 = new TinyPoint(-10.0, hh / 2 + (20.0 * 5 / 6.0));
    TinyPoint p3 = new TinyPoint(-10.0 - ww * 1 / 5, hh / 2 + (20.0 * 2 / 3.0));
    TinyPoint p4 = new TinyPoint(-10.0 + ww * 1 / 5, hh / 2 + (20.0 * 2 / 3.0));
    Matrix4 mat = new Matrix4.identity();

    mat.translate(xx + ww / 2, yy + hh / 2, 0.0);
    mat.rotateZ(angle);
    canvas.pushMulMatrix(mat);
    canvas.drawLine(stage, p1, p2, p);
    canvas.drawLine(stage, p2, p3, p);
    canvas.drawLine(stage, p3, p4, p);
    canvas.popMatrix();
  }

  void onPush(String id) {
    print("id == ${id}");
    switch (id) {
      case "select_button":
        if (!child.contains(tipSelect)) {
          child.add(tipSelect);
        }
        break;
      case "back_button":
        game.stage.root.clearChild();
        game.stage.root.addChild(game.playScene);
        break;
      case "yes_button":
        GameTip t =
            game.environ.targetRed.program.getTip(selectTipX, selectTipY);
        if (t.dxys.length > 0) {
          int tmp = t.dxys[0].dx;
          t.dxys[0].dx = -1 * t.dxys[0].dy;
          t.dxys[0].dy = tmp;
        }
        break;
      case "no_button":
        GameTip t =
            game.environ.targetRed.program.getTip(selectTipX, selectTipY);
        if (t.dxys.length > 1) {
          int tmp = t.dxys[1].dx;
          t.dxys[1].dx = -1 * t.dxys[1].dy;
          t.dxys[1].dy = tmp;
        }
        break;
    }
  }
}
