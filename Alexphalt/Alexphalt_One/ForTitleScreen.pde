class ForTitleScreen {
  float a = 0.0;
  float s = 0.0;
  PImage[] spriteImg = new PImage[8];
  boolean boyFlag = true;

  void all() {
    loadImageforRunningBoy();
    drawWelcomeText();
    drawStartButten();
  }

  void loadImageforRunningBoy() {
    background(128);
    spriteImg[0] = loadImage("0.png");
    spriteImg[1] = loadImage("1.png");
    spriteImg[2] = loadImage("2.png");
    spriteImg[3] = loadImage("3.png");
    spriteImg[4] = loadImage("4.png");
    spriteImg[5] = loadImage("5.png");
    spriteImg[6] = loadImage("6.png");
    spriteImg[7] = loadImage("7.png");
  }

  void drawWelcomeText() {
    if (!boyFlag) {
      rectMode(CORNER);
      fill(128);
      noStroke();
      rect(0, 30, 500, 150);
      rect(20, 490, 450, 300);
      fill(255);
      textSize(32);
      textAlign(CENTER);

      text("Welcome to Alexphalt_One! Click 'START' to begin!", 0, 30, 500, 150);
      textSize(22);
      text("Instructions: use the arrow keys to move the car and avoid traffic. press '1', '2', '3', to change between difficulty levels, and '4' for infinite mode. press '5' to pause. The goal is to pass as many cars as possible!", 20, 490, 450, 300);
    }
  }

  void drawStartButten() {
    if (!boyFlag) {
      fill(255);
      rectMode(CENTER);
      rect(width/2, height/2-140, 200, 100);
      textSize(45);
      fill(0);
      text("START", width/2, height/2-115, 200, 100);
    }
  }

  void imageRunningBoy() {
    int timeMs = millis();
    int msToNext = 100;
    int imgCnt = timeMs/msToNext;
    int imgIdx =  imgCnt % 8;


    rectMode(CENTER);
    imageMode(CENTER);
    noStroke();
    fill(128);

    pushMatrix();
    translate(width/2-14, height/2+30);
    scale(s); 
    if (boyFlag) {
      a = a + 0.008;
      s = sin(a)*2;
    }

    if (s >= 1.999) {
      boyFlag = false;
    }
    rect(0, 0, width, height);    
    image(spriteImg[imgIdx], 0, 0, 120, 115);
    println(a, s);
    popMatrix();
  }

  boolean determinMouseInStartRec() {
    return mouseButton == LEFT && mouseX > width/2-100 && mouseX < width/2+100 && mouseY > height/2-190 && mouseY < height/2 -90;
  }
}
