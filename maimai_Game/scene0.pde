int scene0UpdateTimerDef = 2;

int scene0BgColorR = 253;
int scene0BgColorG = 170;
int scene0BgColorB = 255;
int scene0BgColorGChange = -1;
int scene0BgColorGTimer = scene0UpdateTimerDef - 1;

PImage scene0Cover;

int[] scene0TextSize = {60, 50, 70};
int scene0TextSizeChange = 1;
int scene0TextSizeTimer = scene0UpdateTimerDef;

void scene0Initialize(){
  scene0Cover = loadImage("maimaiMurasaki.png");
  scene0Cover.resize(width/3, 0);
}

void scene0Update() {
    if(scene0BgColorG > 230 || scene0BgColorG < 160){
        scene0BgColorGChange *= -1;
    }
    if(scene0BgColorGTimer <= 0){
        scene0BgColorG += scene0BgColorGChange;
        scene0BgColorGTimer = scene0UpdateTimerDef;
    } else {
        scene0BgColorGTimer--;
    }

    if(scene0TextSize[0] > scene0TextSize[2] || scene0TextSize[0] < scene0TextSize[1]){
        scene0TextSizeChange *= -1;
    }
    if(scene0TextSizeTimer <= 0){
        scene0TextSize[0] += scene0TextSizeChange;
        scene0TextSizeTimer = scene0UpdateTimerDef;
    } else {
        scene0TextSizeTimer--;
    }
    
    image(scene0Cover, width/2, height/2 - 150);
    textSize(scene0TextSize[0]);
    fill(255);
    text("Press any key to start", width/2, height/2 + 270);
}