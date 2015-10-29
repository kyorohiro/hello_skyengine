import 'dart:math' as math;
import 'dart:async';
import '../glogic/tip.dart';
import '../glogic/program.dart';
import '../glogic/target.dart';

class GameEnvirone {
  GameTarget targetRed;
  GameTarget targetBlue;
  double fieldX = 50.0;
  double fieldY = 50.0;
  double fieldWidth = 700.0;
  double fieldHeight = 500.0;

  GameEnvirone() {
    targetRed = new GameTargetSource(this, 50.0, "red");
    targetBlue = new GameTargetSource(this, 50.0, "blue");
  }

  List<GameTarget> getEnemy(GameTarget own) {
    List<GameTarget> l = [];
    if(own.groupName != targetRed.groupName) {
      l.add(targetRed);
    }
    if(own.groupName != targetBlue.groupName) {
      l.add(targetBlue);
    }
    return l;
  }

  bool searchEnemy(GameTarget base,
    double starting, double ending,
    double startDist, double endDist) {
    double s = base.angle+starting;
    double e = base.angle+ending;
    List<GameTarget> l = getEnemy(base);
    for(GameTarget t in l) {
      double d = distance(base, t);
      double a = angle(base, t);
      //print("## a=${a}   d=${d} n=${normalizeAngle(base.angle)}");

      double ss = normalizeAngle(a-startDist);
      double ee = normalizeAngle(a-ending);

      if(ss>=0 && ee<=0) {
      //  print("find!!");
        return true;
      }
    }
    return false;
  }

  static double normalizeAngle(double a) {
    a = a%(2*math.PI);
    if(a<math.PI) {
      return a;
    } else {
      return -math.PI+(a-math.PI);
    }
  }

  static double distance(GameTarget p1, GameTarget p2) {
    double x = p1.x-p2.x;
    double y = p1.y-p2.y;
    return math.sqrt(x*x+y*y);
  }

  static double angle(GameTarget p1, GameTarget p2) {
    double x = p1.x-p2.x;
    double y = p1.y-p2.y;
    return math.atan2(y, x);
  }

  void red() {
    //
    targetBlue.program.setTip(1, 1, new GameTip.advance(dx: 0, dy: 1));
    targetBlue.program.setTip(1, 2, new GameTip.nop(dx: 0, dy: 1));
    targetBlue.program.setTip(1, 3, new GameTip.nop(dx: 0, dy: 1));
    targetBlue.program.setTip(1, 4, new GameTip.turning(dx: -1, dy: 0));

    //
    targetRed.program.setTip(1, 1, new GameTip.advance(dx: 0, dy: 1));
    targetRed.program.setTip(1, 2, new GameTip.nop(dx: 0, dy: 1));
    targetRed.program.setTip(1, 3, new GameTip.nop(dx: 0, dy: 1));
    targetRed.program.setTip(1, 4, new GameTip.turning(dx: 0, dy: 1));
    targetRed.program.setTip(1, 5, new GameTip.searchEnemy(yesDx:-1,yesDy:0));

  }
}
