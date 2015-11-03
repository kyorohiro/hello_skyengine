part of gboard;

class ProgramScreeSetting extends TinyDisplayObject {


  static GameTip id2Tip(String id) {
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

  static String id2Path(String id) {
    print("-------------${id}");
    return id;
  }

  static String tipID2Path(int id) {
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


  static TinyDisplayObject newSelectButton(TinyGameBuilder builder, TinyButtonCallback onTouchCallback) {
    TinyImageButton button = new TinyImageButton(builder, "select_button", "assets/con_sel.png", 80.0, 80.0, onTouchCallback);
//    TinyButton button = new TinyButton("select_button", 80.0, 80.0, onPush);
    button.mat = new Matrix4.translationValues(500.0, 500.0, 0.0);
    button.bgcolorOn = new TinyColor.argb(0x22, 0xFF, 0x00, 0x00);
    button.bgcolorOff = new TinyColor.argb(0xff, 0xff, 0xff, 0xff);
    button.bgcolorFocus = new TinyColor.argb(0x11, 0x00, 0xff, 0x00);
    return button;
  }
  static TinyDisplayObject newChaButton(TinyGameBuilder builder, TinyButtonCallback onTouchCallback) {
    TinyImageButton button = new TinyImageButton(builder, "cha_button", "assets/con_cha.png", 80.0, 80.0, onTouchCallback);
//    TinyButton button = new TinyButton("select_button", 80.0, 80.0, onPush);
    button.mat = new Matrix4.translationValues(400.0, 500.0, 0.0);
    button.bgcolorOn = new TinyColor.argb(0x22, 0xFF, 0x00, 0x00);
    button.bgcolorOff = new TinyColor.argb(0xff, 0xff, 0xff, 0xff);
    button.bgcolorFocus = new TinyColor.argb(0x11, 0x00, 0xff, 0x00);
    return button;
  }
  static TinyDisplayObject newYesButton(TinyGameBuilder builder, TinyButtonCallback onTouchCallback) {
    TinyImageButton button = new TinyImageButton(builder, "yes_button", "assets/con_yes_rot.png", 80.0, 80.0, onTouchCallback);
    //TinyButton button = new TinyButton("yes_button", 80.0, 80.0, onPush);
    button.mat = new Matrix4.translationValues(600.0, 500.0, 0.0);
    button.bgcolorOn = new TinyColor.argb(0x22, 0xFF, 0x00, 0x00);
    button.bgcolorOff = new TinyColor.argb(0xff, 0xff, 0xff, 0xff);
    button.bgcolorFocus = new TinyColor.argb(0x11, 0x00, 0xff, 0x00);
    return button;
  }

  static TinyDisplayObject newNoButton(TinyGameBuilder builder, TinyButtonCallback onTouchCallback) {
    TinyImageButton button = new TinyImageButton(builder, "no_button", "assets/con_no_rot.png", 80.0, 80.0, onTouchCallback);
  //  TinyButton button = new TinyButton("no_button", 80.0, 80.0, onPush);
    button.mat = new Matrix4.translationValues(700.0, 500.0, 0.0);
    button.bgcolorOn = new TinyColor.argb(0x22, 0xFF, 0x00, 0x00);
    button.bgcolorOff = new TinyColor.argb(0xff, 0xff, 0xff, 0xff);
    button.bgcolorFocus = new TinyColor.argb(0x11, 0x00, 0xff, 0x00);
    return button;
  }
  static TinyDisplayObject newBackButton(TinyGameBuilder builder, TinyButtonCallback onTouchCallback){
    TinyButton button = new TinyButton("back_button", 200.0, 120.0, onTouchCallback);
    button.mat = new Matrix4.translationValues(30.0, 480.0, 0.0);
    button.bgcolorOn = new TinyColor.argb(0x22, 0xFF, 0x00, 0x00);
    button.bgcolorOff = new TinyColor.argb(0x00, 0x00, 0x00, 0xff);
    button.bgcolorFocus = new TinyColor.argb(0x11, 0x00, 0xff, 0x00);
    return button;
  }

}
