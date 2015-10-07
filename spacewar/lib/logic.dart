part of spacewar;

class Logic extends DisplayObject {

  @override
  String objectName = "logic";

  Sun sun = new Sun();
  SpaceShip spaceShip = new SpaceShip();
  Joystick joystick = new Joystick();
  Logic() {
    child.add(sun);
    child.add(spaceShip);
    child.add(joystick);
  }

  void onTick(Stage stage, int timeStamp) {
    double v = spaceShip.dx + spaceShip.dy;
    if(v >2.0) {
      // game over
      child.clear();
      child.add(sun);
      child.add(spaceShip);
      child.add(joystick);
      sun.onInit(stage);
      spaceShip.onInit(stage);
      joystick.onInit(stage);
    }
  }
}
