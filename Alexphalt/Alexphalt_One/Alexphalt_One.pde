boolean flag = false, flagForRestart = false, flagForStart = true;
ForTitleScreen fts = new ForTitleScreen();
Start start = new Start();
void setup() {
  size(500, 700);
  fts.all();
  start.all();
}
void draw() {
  if (flag) {
    background(128);
    if (flagForStart) {
      start.start();
    } 
    if(flagForRestart) {
      start.reStart();
    }
  } else {
    fts.imageRunningBoy();
    fts.drawWelcomeText();
    fts.drawStartButten();

  }
}
void mousePressed() {
  if (fts.determinMouseInStartRec()) {
    flag = true;
  }
  if (new Start().forRestart() && !new Start().gameOver()) {
    flagForRestart = true;
    flagForStart = false;
  }
}
void keyPressed() {
  start.DirectionPressed();
  start.levelAndPauseChoose();
}
void keyReleased() {
  start.directionReleased();
}
