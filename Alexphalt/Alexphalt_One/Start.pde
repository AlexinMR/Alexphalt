class Start {
  float [] carX = new float[30];
  float [] carY = new float[carX.length];

  float userCarX;
  float userCarY;

  //for moving background
  PImage bgpic;
  float speedbgpic;
  float ylocationbgpic1 = -30;
  float ylocationbgpic2 = ylocationbgpic1 - 900;

  PImage userCarPic;
  PImage movingCars;
  float left = 0;
  float right = 0;
  float up = 0;
  float down = 0;
  int scoreNum = 0;

  String level = "0";

  float pause = 0;

  float pauseclr = 0;
  float pausespeed = 5;

  float winGoal = 50;

  float speedFrames = 100;
  boolean infinite = false;
  float userCarSpeed = 0;

  //for storing scores in an array,
  int[] scoreList = new int[5];

  //for only record onetime of score
  boolean oneTimeRecording = true;

  //for restart
  boolean forRestart = true, gameOverInStart = false;
  PImage gameOverPic;
  float rotateX = 0, millis1, millis2, scaleX = 0.1, translateX = 0, translateY = 0;
  boolean transForRotate = false, stopAddingMillis = true;
  
  void all(){
    loadBG();
    initializeCarPosition();
    loadPicForCars();
  }
  
  void initializeCarPosition() {
    //initialize value for usercar
    userCarX = 225;
    userCarY = 535;

    //initialize value for x, y of movingcar
    carX[0] = 125;
    carY[0] = 180;
    carX[1] = 325;
    carY[1] = 280;
    for (int x = 2; x < carX.length; x++) {
      carX[x] = (int)random(0, 5) * 100 + 25;
      carY[x] = (int)random( (x+1)*(-300)+80, x*(-300)-80)-200;
    }
  }

  void start() {
    start.drawBGmoving();  

    start.drawLevelAndScore();
    start.constrainUserCarNotOutOfBounds();

    start.moveRandonCars();

    pauseclr += pausespeed;
    pauseclr %= 255;

    start.resetMovingCars();
    start.pauseCondition();
    start.gameOverCondition();
    start.winCondition();
    start.infiniteMode();
  }
  void reStart() {
    //for reset all values except scoreNum,
    if (forRestart) {
      start.initializeCarPosition();
      ylocationbgpic1= -30;
      ylocationbgpic2= ylocationbgpic1-900;
      level = "0";

      pause = 0;

      pauseclr = 0;
      pausespeed = 5;

      winGoal = 50;
      scoreNum = 0;
      speedFrames = 100;
      infinite = false;
      userCarSpeed = 0;
      forRestart = false;
      flagForRestart = false;
      flagForStart = true;
      gameOverInStart = false;
      oneTimeRecording = true;
      
      //gameoverpart
      forRestart = true; gameOverInStart = false;
      rotateX = 0; millis1 = 0; millis2 = 0; scaleX = 0.1; translateX = 0; translateY = 0;
      transForRotate = false; stopAddingMillis = true;
    }
  }
  void drawLevelAndScore() {
    fill(255);
    textSize(30);
    text("Score: " + scoreNum, 370, 30);
    text("Level: " + level, 370, 59);
  }
  void constrainUserCarNotOutOfBounds() {
    //initializes user car position and prevents from leaving bounds
    //fill(232, 80, 125);
    noStroke();
    noFill();
    rectMode(CORNERS); 
    userCarX = constrain(userCarX + (right - left) * userCarSpeed, 0, width-51);
    userCarY = constrain(userCarY + (down - up) * userCarSpeed, 0, height-80);
    rect(userCarX, userCarY, userCarX + 51, userCarY + 80); 
    image(userCarPic, userCarX, userCarY, 51, 80);
  }


  void moveRandonCars() {
    //initialize random cars
    for (int x = 0; x < carX.length; x++) {
      noFill();
      noStroke();
      rect(carX[x], carY[x], carX[x] + 51, carY[x] + 80);
      image(movingCars, carX[x], carY[x], 51, 80);
      carY[x] += userCarSpeed;
    }
  }


  void resetMovingCars() {

    for (int x = 0; x < carX.length; x++) {
      if (carY[x] >= height) {
        carY[x] = -8920;//(int)random((x+1)*-500+30, x*-500-30);
        carX[x] = (int)random(0, 5) * 100 + 25;
        scoreNum++;
      }
    }
  }


  void pauseCondition() {

    for (int x = 0; x < carX.length; x++) {

      if (pause == 1 && !((userCarX + 3< carX[x]+51) & (userCarY < carY[x]+80)) & ((userCarX+51-3>carX[x]) & (userCarY+80 > carY[x])) && !infinite) {
        fill(pauseclr, 0, 0);
        textSize(45);
        text("PAUSING...", 250, 300);
      }
    }
  }

  void gameOverCondition() {
    for (int x = 0; x < carX.length; x++) {
      if (((userCarX + 3< carX[x]+51) & (userCarY < carY[x]+80)) & ((userCarX+51-3>carX[x]) & (userCarY+80 > carY[x]))) {
        gameOverInStart = true;
        /*
        fill(255, 0, 0);
         textSize(60);
         text("Game Over!!", 250, height/2-150);
         */
        userCarSpeed = 0;

        gameOverPicRotating();

        forRestart = true;//164444444444444444444444444444
        recordAndText();
        drawRestart();
      }
    }
  }
  void gameOverPicRotating() {
    pushMatrix();
    ///translate-----
    translate(translateX, translateY);
    translateX += 2;
    translateY += 1.84;
    if (translateX > 250) {
      translateX = 250;
      transForRotate = true;
    }
    if (translateY > 230) {
      translateY = 230;
    }
    //scalse
    scale(scaleX);
    scaleX += (0.9/125);
    if (scaleX > 0.7) {
      scaleX = 0.7;
    }
    //rotate-----
    rotate(rotateX);
    millis1 = millis();
    millis2 = millis1/2;
    if(stopAddingMillis){
      rotateX = millis2/72;
    }
    if (transForRotate) {
      if (sin(rotateX) < 0.14 && sin(rotateX) > -0.14) {
        rotateX = 0;
        stopAddingMillis = false;
      }
    }

    imageMode(CENTER);
    image(gameOverPic, 0, 0);
    popMatrix();
  }
  boolean gameOver() {
    return gameOverInStart;
  }
  void winCondition() {

    if (scoreNum >= winGoal & !infinite & pause !=1) {
      fill(255, 255, 255);
      textSize(60);
      text("You Win!!", 250, height/2-150);
      userCarSpeed = 0;
      //call recording function

      forRestart = true;//164444444444444444444444444444
      recordAndText();
      drawRestart();
    }
  }

  void infiniteMode() {
    if (infinite) {
      speedFrames--;
      winGoal = 99999999;
      if (speedFrames==0) {
        userCarSpeed++;
        speedFrames = 100;
      }
    } else {
      winGoal = 50;
    }
  }


  void loadPicForCars() {
    //usercarpic
    userCarPic = loadImage("usercar.png");
    //movingcars
    movingCars = loadImage("movingcar.png");
    gameOverPic = loadImage("gameOver.png");
  }

  void initialAllKindsOfValue() {
    //pause = 0;
    //pauseclr = 0;
    //pausespeed = 5;
    //winGoal = 30;
    //scoreNum = 0;


    //for infinite mode
    //speedFrames = 100;
    infinite = false;
  }

  void DirectionPressed() {
    //Creates smooth movement
    if (key == CODED) {
      if (keyCode == LEFT) {
        left = 1;
      }    
      if (keyCode == RIGHT) {
        right = 1;
      }
      if (keyCode == UP) {
        up = 1;
      }
      if (keyCode == DOWN) {
        down = 1;
      }
    }
  }

  void levelAndPauseChoose() {

    if (key == '1') {
      userCarSpeed = 10;
      level = "1";
      pause = 0;
      infinite = false;
    } else if (key == '2') {
      userCarSpeed = 13;
      level = "2";
      pause = 0;
      infinite = false;
    } else if (key == '3') {
      userCarSpeed = 18;
      level = "3";
      pause = 0;
      infinite = false;
    } else if (key == '4') {
      speedFrames = 100; 
      infinite = true;
      level = "--";
      pause = 0;
    } else if (key == '5') {
      userCarSpeed = 0;
      pause = 1;
      infinite = false;
    }
  }

  void directionReleased() {
    if (key == CODED) {
      if (keyCode == LEFT) {
        left = 0;
      }
      if (keyCode == RIGHT) {
        right = 0;
      }
      if (keyCode == UP) {
        up = 0;
      }
      if (keyCode == DOWN) {
        down = 0;
      }
    }
  }

  void loadBG() {
    bgpic = loadImage("background.tif");
  }

  void drawBGmoving() {
    //for moving background
    speedbgpic = userCarSpeed / 2;
    imageMode(CORNER);
    image(bgpic, 0, ylocationbgpic1);
    image(bgpic, 0, ylocationbgpic2);

    ylocationbgpic1 += speedbgpic;
    ylocationbgpic2 += speedbgpic;

    if (ylocationbgpic1 >= 870) {
      ylocationbgpic1 = ylocationbgpic2 - 900;
    }
    if (ylocationbgpic2 >= 870) {
      ylocationbgpic2 = ylocationbgpic1 - 900;
    }
  }

  void recordScoreList() {//138
    int temp = scoreNum;
    for (int x = 4; x >= 0; x--) {
      if (x>0) {
        scoreList[x] = scoreList[x-1];
      } else {
        scoreList[x] = temp;
      }
    }
  }

  void sort_textForScoreList() {
    for (int x = 0; x < 4; x++) {
      for (int y = x + 1; y < 5; y++) {
        if (scoreList[x] < scoreList[y]) {
          int temp = scoreList[x];
          scoreList[x] = scoreList[y];
          scoreList[y] = temp;
        }
      }
    }
  }
  void textScoreList() {
  //  rectMode(CENTER);
  //  fill(0);
  //  rect(width/2,height/2,100,200);
    for (int x = 0; x < 5; x++) {
      textSize(30);
      fill(255);
      text(x+1+". "+scoreList[x], width/2, 370+x*35);
    }
  }
  void recordAndText() {
    //
    if (oneTimeRecording) {
      recordScoreList();
      sort_textForScoreList();
      oneTimeRecording = false;
    }

    textScoreList();
  }
  void drawRestart() {
    pushMatrix();
    textAlign(CENTER);
    translate(width/2,height/2+260);
    fill(255, 0, 0);
    noStroke();
    rectMode(CENTER);
    rect(0,0, 160, 70);
    textSize(33);
    fill(0, 255, 0);
    text("RESTART", 0,8, 160, 60);
    popMatrix();
  }
  boolean forRestart() {
    return mouseButton == LEFT && mouseX > width/2-80 && mouseX < width/2+80 && mouseY < height/2 + 280 && mouseY > height/2 + 220;
  }
}
