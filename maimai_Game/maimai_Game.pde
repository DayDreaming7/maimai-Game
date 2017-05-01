//import processing.sound.*;
import ddf.minim.*;
import org.multiply.processing.*;
import lord_of_galaxy.timing_utils.*;
import arb.soundcipher.*; 

//Sounds
Minim minim;
AudioPlayer song;
String songName = "echo";
float songVolGain = -5.0;
AudioSample tapSound;
String tapSoundName = "tap";
float tapSoundVolGain = 8.0;

//SoundCipher
SCScore pattern;

//ArrayLists
ArrayList <Tap> taps;
ArrayList <HitPoint> hitPoints;
ArrayList <StartPoint> startPoints;

//Shapes
PShape psTap;
PShape tapOutter;
PShape tapInner;
PShape tapPoint;

float tapDefSpeed = 10;

//playing
Stopwatch playTimer;
boolean playing = false;

float displayTimeBuffer = 100;
float soundTimeBuffer = 3;

int tapCount = 0;
int movingTime;

boolean keyDown[] = {false, false, false, false, false, false, false, false};

//----------------------------------------------------------------------------
void setup() {
  fullScreen();
  //size(1200,800);
  orientation(LANDSCAPE);
  noStroke();
  ellipseMode(RADIUS);
  shapeMode(CENTER);
  textAlign(CENTER, CENTER);
  frameRate(60);

  taps = new ArrayList();
  hitPoints = new ArrayList();
  startPoints = new ArrayList();

  minim = new Minim(this);
  song = minim.loadFile(songName + ".mp3");
  tapSound = minim.loadSample(tapSoundName + ".mp3", 512);
  song.setGain(songVolGain);
  tapSound.setGain(tapSoundVolGain);

  pattern = new SCScore();
  pattern.addCallbackListener(this);
  pattern.tempo(60*1000); //frameRate * 1000

  playTimer = new Stopwatch(this);

  initializeAll(); //Size, Shapes, HitPoints of mainRing
}

void draw() {
  background(bgColor);
  update();
}

void keyPressed() {
  if (key == ' ') {
    playing = !playing;

    if (playing) {
      song.rewind();
      playTimer.start();
      song.play();
      pattern.play();
    } else {
      song.pause();
      gameReset();
    }
  }
  if (playing) {
    if (key == '9') {
      keyDown[0] = true;
      println("P0 down");
    }
    if (key == 'o'|| key == 'O') {
      keyDown[1] = true;
      println("P1 down");
    }
    if (key == 'l'|| key == 'L') {
      keyDown[2] = true;
      println("P2 down");
    }
    if (key == ',') {
      keyDown[3] = true;
      println("P3 down");
    }
    if (key == 'm'|| key == 'M') {
      keyDown[4] = true;
      println("P4 down");
    } 
    if (key == 'j' || key == 'J') {
      keyDown[5] = true;
      println("P5 down");
    }
    if (key == 'u' || key == 'U') {
      keyDown[6] = true;
      println("P6 down");
    }
    if (key == '8') {
      keyDown[7] = true;
      println("P7 down");
    }
  }
}

void keyReleased() {
  if (playing) {
    if (key == '9') {
      keyDown[0] = false;
    }
    if (key == 'o'|| key == 'O') {
      keyDown[1] = false;
    }
    if (key == 'l'|| key == 'L') {
      keyDown[2] = false;
    }
    if (key == ',') {
      keyDown[3] = false;
    }
    if (key == 'm'|| key == 'M') {
      keyDown[4] = false;
    } 
    if (key == 'j' || key == 'J') {
      keyDown[5] = false;
    }
    if (key == 'u' || key == 'U') {
      keyDown[6] = false;
    }
    if (key == '8') {
      keyDown[7] = false;
    }
  }
}

void handleCallbacks(int callbackID) {
  // if (callbackID == 0) {
  //   tapSound.trigger();
  // }
  if (callbackID == 1) {
    taps.get(tapCount).visible = true;
    tapCount++;
  }
}