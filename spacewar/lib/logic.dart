part of spacewar;

class Logic extends DisplayObject {

  @override
  String objectName = "logic";

  Sun sun = new Sun();
  SpaceShip spaceShip = new SpaceShip();
  Joystick joystick = new Joystick();
  Enemy enemy = new Enemy();

  Logic() {
    child.add(sun);
    child.add(spaceShip);
    child.add(joystick);
    child.add(enemy);
  }

  void onTick(Stage stage, int timeStamp) {
    double v = spaceShip.dx + spaceShip.dy;
    if(v >2.5 || spaceShip.life < 0) {
      // game over
      child.clear();
      child.add(sun);
      child.add(spaceShip);
      child.add(joystick);
      child.add(enemy);
      sun.onInit(stage);
      spaceShip.onInit(stage);
      joystick.onInit(stage);
      enemy.onInit(stage);
    } else if(enemy.life < 0) {
      // clear game
      spaceShip.life += 5;
      enemy.onInit(stage);
    }
  }
}
