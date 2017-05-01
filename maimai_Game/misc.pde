float getDisBtwPoints(float tx1, float ty1, float tx2, float ty2) {
  float x1 = tx1;
  float y1 = ty1;
  float x2 = tx2;
  float y2 = ty2;

  float distance = sqrt(sq(x1-x2)+sq(y1-y2));
  return distance;
}

void songReset() {
  totalScore = 0;
  combo = 0;
  bestCombo = 0;
  tapCount = 0;
  playTimer.reset();
  pattern.stop();
  for (Tap temp : taps) {
    temp.reinitialize();
  }
}

void fullReset(){
  totalScore = 0;
  combo = 0;
  bestCombo = 0;
  tapCount = 0;
  playTimer.reset();
  pattern.stop();

  println(taps.size());
  println(hitPoints.size());
  println(startPoints.size());
  println(buttons.size());
  println("^");

  taps.clear();
  hitPoints.clear();
  startPoints.clear();
  buttons.clear();

  println(taps.size());
  println(hitPoints.size());
  println(startPoints.size());
  println(buttons.size());
  println("v");
}

class Button {
  int x, y, w, h;
  color normalColor, overColor, clickColor, textColor;
  String text;
  int representSongNo;
  boolean clicked = false;

  Button(int tx, int ty, int tw, int th, color tnc, color toc, color tcc, String tt, color ttc, int tsn) {
    x = tx;
    y = ty;
    w = tw;
    h = th;
    normalColor = tnc;
    overColor = toc;
    clickColor = tcc;
    text = tt;
    textColor = ttc;
    representSongNo = tsn;
  }

  boolean isOver() {
    if (mouseX > x - w/2 && mouseX < x + w/2 && mouseY > y - h/2 && mouseY < y + h/2) {
      return true;
    } else {
      return false;
    }
  }

  boolean isMousePressed() {
    if (mousePressed) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    if (isOver() && isMousePressed()) {
      fill(clickColor);
      if (!clicked) {
        if (representSongNo > 0) {
          selectedSongNo = representSongNo;
        } else if (representSongNo == -1) {
          scene2_initializeAll();
          scene = 2;
        } else if (representSongNo == -2) {
          tapDefSpeed += 1;
        } else if (representSongNo == -3) {
          tapDefSpeed -= 1;
        }
        clicked = true;
      }
    } else if (isOver()) {
      clicked = false;
      fill(overColor);
    } else {
      clicked = false;
      fill(normalColor);
    }
    rect(x, y, w, h);
    fill(textColor);
    text(text, x, y - h/15);
  }
}