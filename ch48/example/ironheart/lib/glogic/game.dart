part of glogic;

class Game {
  TinyGameBuilder f;
  PlayScene playScene;
  StartScreen startScene;
  ProgramScree progScene;
  TinyStage stage;
  GameEnvirone environ;

  Game(this.f) {

    environ = new GameEnvirone();
    playScene = new PlayScene(this);
    startScene = new StartScreen(this);
    progScene = new ProgramScree(this);
    stage = f.createStage(new TinyGameRoot(800.0, 600.0));

    //
    environ.red();
  }


}
