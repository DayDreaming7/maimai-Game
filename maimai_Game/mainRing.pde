void updateMainRing(){
  drawMainRing();
  drawHitMarkText();
  drawComboText();
}

void drawMainRing() {
  fill(ringColor);
  ellipse(displayWidth/2, displayHeight/2, mainRingOutterR, mainRingOutterR);
  fill(bgColor);
  ellipse(displayWidth/2, displayHeight/2, mainRingInnerR, mainRingInnerR);

  // for(HitPoint temp:hitPoints){
  //   temp.display();
  // }

  for (StartPoint temp : startPoints) {
    temp.display();
  }
}

void drawHitMarkText(){
  textSize(40);
  for(int i = 0; i <= 7; i++){
    if(hitMarkText[i][2] == 1.0 && hitMarkText[i][3] > 0){
      text("Perfect", hitMarkText[i][0], hitMarkText[i][1]);
      hitMarkText[i][3] -= 1.0;
    } else if(hitMarkText[i][2] == 2.0 && hitMarkText[i][3] > 0){
      text("Great", hitMarkText[i][0], hitMarkText[i][1]);
      hitMarkText[i][3] -= 1.0;
    } else if(hitMarkText[i][2] == 3.0 && hitMarkText[i][3] > 0){
      text("Good", hitMarkText[i][0], hitMarkText[i][1]);
      hitMarkText[i][3] -= 1.0;
    } else if(hitMarkText[i][2] == 4.0 && hitMarkText[i][3] > 0){
      text("Miss", hitMarkText[i][0], hitMarkText[i][1]);
      hitMarkText[i][3] -= 1.0;
    }
  }
}

void drawComboText(){
  textSize(80);
  text(totalScore, width/2, height/2 - 50);
  textSize(60);
  text(combo, width/2, height/2 + 50);
}


class HitPoint {
  float x, y;
  HitPoint(float tx, float ty) {
    x = tx;
    y = ty;
  }

  void display() {
    fill(hitPointOutterColor);
    ellipse(x, y, hitPointOutterR, hitPointOutterR);
    fill(hitPointInnerColor);
    ellipse(x, y, hitPointInnerR, hitPointInnerR);
  }
}

class StartPoint {
  float x, y;
  StartPoint(float tx, float ty) {
    x = tx;
    y = ty;
  }

  void display() {
    fill(255);
    ellipse(x, y, startPointR, startPointR);
  }
}