part of spacewar;

class Logic extends DisplayObject {

  @override
  String objectName = "logic";

  Logic() {
    child.add(new Sun());
    child.add(new SpaceShip());
    child.add(new Joystick());
  }
}
