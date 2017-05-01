void initializeAll() {
  initSizeValue();
  initAllShape();
  initHitPoints();
  initStartPoints();

  initPatterns();

  initTextPos();
  // println(startPoints.get(0).x);
  // println(startPoints.get(0).y);
  // println(hitPoints.get(0).x);
  // println(hitPoints.get(0).y);
}

//Sizes of mainRing
float centreX, centreY;

float mainRingOutterR;
float mainRingInnerR;
int ringThick = 50;

//Sizes of tabs
float tapOutterR;
float tapInnerR;
float tapPointR = 3;
int tapThick = 20;

float hitPointOutterR = 30;
float hitPointInnerR = 5;

float startPointR = 5;

//Colors
color bgColor = #5C5D5D;
color ringColor = #FBFF39;
color tapColor = #FA5BB3;
color tapPointColor = #FA5BB3;
color hitPointOutterColor = #86FFF8;
color hitPointInnerColor = #F5FF76;

//Texts
float[][] hitMarkText = new float[8][4];
int textPosOffset = 70;
float hitMarkTextShowTime = 20.0;

//Scores
int combo = 0;
int bestCombo = 0;
int totalScore = 0;

int scoreP = 500;
int scoreG = 400;
int scoreD = 250;
int scoreM = 0;

void initSizeValue() {
  centreX = displayWidth/2;
  centreY = displayHeight/2;

  mainRingOutterR = min(displayWidth /20 *10, displayWidth /20 *10) /2;
  mainRingInnerR = mainRingOutterR - ringThick;

  tapOutterR = min(displayWidth /20 *1.5, displayWidth /20 *1.5) /2;
  tapInnerR = tapOutterR - tapThick;
}

void initAllShape() {
  psTap = createShape(GROUP);

  tapOutter = createShape(ELLIPSE, 0, 0, tapOutterR, tapOutterR);
  tapOutter.setFill(tapColor);
  tapInner = createShape(ELLIPSE, 0, 0, tapInnerR, tapInnerR);
  tapInner.setFill(bgColor);
  tapPoint = createShape(ELLIPSE, 0, 0, tapPointR, tapPointR);
  tapPoint.setFill(tapPointColor);

  psTap.addChild(tapOutter);
  psTap.addChild(tapInner);
  psTap.addChild(tapPoint);
}

void initHitPoints() {
  for (byte i = 1; i<=8; i++) {
    float x, y;
    float alpha = 0;
    int xDirection = 1;
    int yDirection = 1;
    switch(i) {   
    case 1:
    case 4:
    case 5:
    case 8:
      alpha = 22.5;
      break;
    case 2:
    case 3:
    case 6:
    case 7:
      alpha = 67.5;
      break;
    }
    switch(i) {    
    case 5:
    case 6:
      xDirection = -1;
      break;
    case 1:
    case 2:
      yDirection = -1;
      break;
    case 7:
    case 8:
      xDirection = -1;
      yDirection = -1;
    }
    x = centreX + xDirection * (mainRingOutterR - ringThick /2) * sin(radians(alpha));
    y = centreY + yDirection * (mainRingOutterR - ringThick /2) * cos(radians(alpha));
    HitPoint temp = new HitPoint(x, y);
    hitPoints.add(temp);
  }
}

void initStartPoints() {
  for (byte i = 1; i<=8; i++) {
    float x, y;
    float alpha = 0;
    int xDirection = 1;
    int yDirection = 1;
    switch(i) {   
    case 1:
    case 4:
    case 5:
    case 8:
      alpha = 22.5;
      break;
    case 2:
    case 3:
    case 6:
    case 7:
      alpha = 67.5;
      break;
    }
    switch(i) {    
    case 5:
    case 6:
      xDirection = -1;
      break;
    case 1:
    case 2:
      yDirection = -1;
      break;
    case 7:
    case 8:
      xDirection = -1;
      yDirection = -1;
    }
    x = centreX + xDirection * (mainRingOutterR - ringThick /2 )/4 * sin(radians(alpha));
    y = centreY + yDirection * (mainRingOutterR - ringThick /2 )/4 * cos(radians(alpha));
    StartPoint temp = new StartPoint(x, y);
    startPoints.add(temp);
  }
}

void initPatterns() {
  println(int(getDisBtwPoints(startPoints.get(0).x, startPoints.get(0).y, hitPoints.get(0).x, hitPoints.get(0).y)/(tapDefSpeed/1000*60)));

  movingTime = int(getDisBtwPoints(startPoints.get(0).x, startPoints.get(0).y, hitPoints.get(0).x, hitPoints.get(0).y)/(tapDefSpeed/1000*60)); //tapDefSpeed / frameRate

  String[] temp = loadStrings("echo.txt");
  for (int i = 0; i < temp.length; i++) {
    float tempSplit[] = float(split(temp[i], "/"));

    pattern.addCallback(int(tempSplit[0]), 0);
    pattern.addCallback(int(tempSplit[0]) - movingTime, 1);
    //println(int(tempSplit[0]) - movingTime);

    Tap tempNew = new Tap(startPoints.get(int(tempSplit[1] - 1)).x, startPoints.get(int(tempSplit[1] - 1)).y, tapDefSpeed, int(tempSplit[1]), tempSplit[0]);
    taps.add(tempNew);
  }
}

void initTextPos() {
  for (int i = 0; i <= 7; i++) {
    float alpha = 0;
    int xDirection = 1;
    int yDirection = 1;
    switch(i + 1) {   
    case 1:
    case 4:
    case 5:
    case 8:
      alpha = 22.5;
      break;
    case 2:
    case 3:
    case 6:
    case 7:
      alpha = 67.5;
      break;
    }
    switch(i + 1) {    
    case 5:
    case 6:
      xDirection = -1;
      break;
    case 1:
    case 2:
      yDirection = -1;
      break;
    case 7:
    case 8:
      xDirection = -1;
      yDirection = -1;
    }

    hitMarkText[i][0] = hitPoints.get(i).x + xDirection * textPosOffset * sin(radians(alpha));
    hitMarkText[i][1] = hitPoints.get(i).y + yDirection * textPosOffset * cos(radians(alpha));
    hitMarkText[i][2] = 0;
    hitMarkText[i][3] = hitMarkTextShowTime;
  }
}