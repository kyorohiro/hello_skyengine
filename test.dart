import 'dart:math' as math;

void main() {
  print("1 1   : ${math.atan2(1.0,1.0)}");
  print("1 0   : ${math.atan2(1.0,0.0)}");
  print("-1 0  : ${math.atan2(-1.0,1.0)}");
  print("-1 -1 : ${math.atan2(-1.0,-1.0)}");
  double aa = math.PI*6;
  double bb = math.atan2(-1.0,-1.0);
}