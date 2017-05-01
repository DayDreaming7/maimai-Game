class Tap {
  float initX, initY;
  float x, y;
  float speed;
  int pos;
  float hitTime;
  float alpha;
  int xDirection = 1;
  int yDirection = 1;
  boolean visible = false;

  float detectR1 = tapInnerR / 4;
  float detectR2 = tapInnerR / 2.5;
  float detectR3 = tapInnerR / 1;
  float detectR4 = tapInnerR + 10;

  Tap(float tx, float ty, float ts, int tp, float tdp) {
    initX = tx;
    initY = ty;
    x = tx;
    y = ty;
    speed = ts;
    pos = tp;
    hitTime = tdp;
  }

  // void checkVisibility() {
  //   //println(hitTime - getDisBtwPoints(startPoints.get(pos - 1).x, startPoints.get(pos - 1).y, hitPoints.get(pos - 1).x, hitPoints.get(pos - 1).y) / (speed/frameRate));
  //   // if(playTimer.time() >= 
  //   // hitTime - (getDisBtwPoints(startPoints.get(pos - 1).x, startPoints.get(pos - 1).y, hitPoints.get(pos - 1).x, hitPoints.get(pos - 1).y) / speed)*(1000/frameRate)/*&& playTimer.time() - hitTime < displayTimeBuffer*/){
  //   //   visible = true;
  //   //   }else{
  //   //     visible = false;
  //   //   }
  //   if (x > width || x < 0 || y > height || y < 0) {
  //     visible = false;
  //   }
  // }

  void move() {
    if (visible) {
      switch(pos) {
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

      switch(pos) {    
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

      x += speed * xDirection * sin(radians(alpha));
      y += speed * yDirection * cos(radians(alpha));
    }
  }

  void display() {
    if (visible) {
      shape(psTap, x, y);
    }
  }

  void checkInput() {
    if (visible) {
      if (getDisBtwPoints(x, y, hitPoints.get(pos-1).x, hitPoints.get(pos-1).y) <= detectR1 && keyDown[pos-1]) {
        hitMarkText[pos-1][2] = 1.0;
        hitMarkText[pos-1][3] = hitMarkTextShowTime;
        tapSound.trigger();
        totalScore += scoreP;
        combo++;
        visible = false;
      } else if (getDisBtwPoints(x, y, hitPoints.get(pos-1).x, hitPoints.get(pos-1).y) <= detectR2 && getDisBtwPoints(x, y, hitPoints.get(pos-1).x, hitPoints.get(pos-1).y) > detectR1 && keyDown[pos - 1]) {
        hitMarkText[pos-1][2] = 2.0;
        hitMarkText[pos-1][3] = hitMarkTextShowTime;
        tapSound.trigger();
        totalScore += scoreG;
        combo++;
        visible = false;
      } else if (getDisBtwPoints(x, y, hitPoints.get(pos-1).x, hitPoints.get(pos-1).y) <= detectR3 && getDisBtwPoints(x, y, hitPoints.get(pos-1).x, hitPoints.get(pos-1).y) > detectR2 && keyDown[pos - 1]) {
        hitMarkText[pos-1][2] = 3.0;
        hitMarkText[pos-1][3] = hitMarkTextShowTime;
        tapSound.trigger();
        totalScore += scoreD;
        combo++;
        visible = false;
      } else if (getDisBtwPoints(x, y, hitPoints.get(pos-1).x, hitPoints.get(pos-1).y) <= detectR4 && getDisBtwPoints(x, y, hitPoints.get(pos-1).x, hitPoints.get(pos-1).y) > detectR3 && keyDown[pos - 1]) {
        hitMarkText[pos-1][2] = 4.0;
        hitMarkText[pos-1][3] = hitMarkTextShowTime;
        println(pos + " " + "Miss");
        totalScore += scoreM;
        bestCombo = max(bestCombo, combo);
        combo = 0;
        visible = false;
      } else if (x > width || x < 0 || y > height || y < 0) {
        hitMarkText[pos-1][2] = 4.0;
        hitMarkText[pos-1][3] = hitMarkTextShowTime;
        println(pos + " " + "Miss");
        totalScore += scoreM;
        bestCombo = max(bestCombo, combo);
        combo = 0;
        visible = false;
      }
    }
  }

  void reinitialize() {
    x = initX;
    y = initY;
    visible = false;
  }
}


void displayAllTabs() {
  for (Tap temp : taps) {
    //temp.checkVisibility();
    temp.move();
    temp.checkInput();
    temp.display();
  }
}