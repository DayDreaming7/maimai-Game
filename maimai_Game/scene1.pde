PImage scene1SongCover1;
PImage scene1SongCover2;
PImage scene1SongCover3;
//PImage scene1SongCover2;
//PImage scene2SongCover3;

int scene1UpdateTimerDef = 2;

int scene1BgColorR = 253;
int scene1BgColorG = 170;
int scene1BgColorB = 255;
int scene1BgColorGChange = -1;
int scene1BgColorGTimer = scene1UpdateTimerDef - 1;

int selectedSongNo = 0;

int btnW, btnH, btnX, btnY;
int btnSeparate = 15;

int sbtnW, sbtnH, sbtnX, sbtnY;

int ubtnW, ubtnH, ubtnX, ubtnY;
int dbtnW, dbtnH, dbtnX, dbtnY;

int speedRW, speedRH, speedRX, speedRY;

color btnNormalColor = #81FAFF;
color btnOverColor = #C6FDFF;
color btnClickColor = #5DD1D6;

String[] btnText = {"echo", "ghost rule", "nightsky", "Go", "^", "v"};
color[] btnTextColor = {#000000, #000000, #000000, #04B42B, #000000, #000000};

int emptyCoverTextSize = 60;
int speedStringSize = 40;

void scene1Initialize() {
  scene1SongCover1 = loadImage("echo.png");
  scene1SongCover1.resize(width/3, 0);
  scene1SongCover2 = loadImage("ghost_rule.jpg");
  scene1SongCover2.resize(width/3, 0);
  scene1SongCover3 = loadImage("nightsky.png");
  scene1SongCover3.resize(width/3, 0);

  btnW = width/4;
  btnH = height/8;
  btnX = width/4*3;
  btnY = height/5;

  sbtnW = width/10;
  sbtnH = sbtnW;
  sbtnX = width - sbtnW/2;
  sbtnY = height - sbtnH/2;

  ubtnW = width/8;
  ubtnH = height/15;
  ubtnX = btnX + btnSeparate/2 + ubtnW/2;
  ubtnY = height/20*13;

  dbtnW = ubtnW;
  dbtnH = ubtnH;
  dbtnX = ubtnX;
  dbtnY = ubtnY + ubtnH + btnSeparate;

  speedRW = ubtnW;
  speedRH = ubtnH * 2 + btnSeparate;
  speedRX = ubtnX - ubtnW/2 - btnSeparate - speedRW/2;
  speedRY = dbtnY - dbtnH/2 - btnSeparate/2;

  for (int i = 1; i <= 3; i++) {
    Button temp = new Button(btnX, btnY + (btnH + btnSeparate) * (i - 1), btnW, btnH, btnNormalColor, btnOverColor, btnClickColor, btnText[i-1], btnTextColor[i-1], i);
    buttons.add(temp);
  }

    Button tempS = new Button(sbtnX, sbtnY, sbtnW, sbtnH, btnNormalColor, btnOverColor, btnClickColor, btnText[3], btnTextColor[3], -1);
    buttons.add(tempS);

    Button tempU = new Button(ubtnX, ubtnY, ubtnW, ubtnH, btnNormalColor, btnOverColor, btnClickColor, btnText[4], btnTextColor[4], -2);
    buttons.add(tempU);

    Button tempD = new Button(dbtnX, dbtnY, dbtnW, dbtnH, btnNormalColor, btnOverColor, btnClickColor, btnText[5], btnTextColor[5], -3);
    buttons.add(tempD);
}

void scene1Update() {
  if (scene1BgColorG > 209 || scene1BgColorG < 130) {
    scene1BgColorGChange *= -1;
  }
  if (scene1BgColorGTimer <= 0) {
    scene1BgColorG += scene1BgColorGChange;
    scene1BgColorGTimer = scene1UpdateTimerDef;
  } else {
    scene1BgColorGTimer--;
  }

  for (Button temp : buttons) {
    temp.display();
  }

  noFill();
  stroke(0);
  strokeWeight(3);
  rect(speedRX, speedRY, speedRW, speedRH);
  textSize(speedStringSize);
  text("Speed:", speedRX - speedRW/5, speedRY - speedRH/5*2);
  textSize(emptyCoverTextSize);
  text(nf(tapDefSpeed, 0, 0), speedRX, speedRY - btnSeparate/4);
  noStroke();

  switch(selectedSongNo) {
  case 0:
    noFill();
    stroke(0);
    strokeWeight(5);
    rect(width/3, height/2, width/3, width/3);
    textSize(emptyCoverTextSize);
    text("Select Song ->", width/3, height/2);
    noStroke();
    break;
  case 1:
    image(scene1SongCover1, width/3, height/2);
    break;
  case 2:
    image(scene1SongCover2, width/3, height/2);
    break;
  case 3:
    image(scene1SongCover3, width/3, height/2);
    break;
  }
}