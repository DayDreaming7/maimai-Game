float getDisBtwPoints(float tx1, float ty1, float tx2, float ty2) {
  float x1 = tx1;
  float y1 = ty1;
  float x2 = tx2;
  float y2 = ty2;

  float distance = sqrt(sq(x1-x2)+sq(y1-y2));
  return distance;
}

void gameReset(){
  totalScore = 0;
  combo = 0;
  bestCombo = 0;
  playTimer.reset();
  pattern.stop();
}