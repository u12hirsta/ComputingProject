class ScrollBar {
  PVector pos, size;
  PVector newPos = new PVector();  
  PVector sSize = new PVector();  
  PVector sPos = new PVector();  
  boolean over, locked;
  float minPos, maxPos; 
  int smooth = 17;
  ScrollBar(PVector pos, PVector size, float sXPos) {
    this.pos = new PVector();
    this.pos = pos;
    this.size = new PVector();
    this.size = size;
    minPos = pos.x-size.x/2;
    maxPos = pos.x+size.x/2;
    changeX(sXPos);
  }
  
  void update() {
    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      locked = true;
    } else if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      newPos.x = constrain(mouseX, minPos, maxPos);
    }
    if (abs(newPos.x - sPos.x) > 1) {
      sPos.x = sPos.x + (newPos.x-sPos.x)/smooth;
    }
  }
  boolean overEvent() {
    if (mouseX >= pos.x-(size.x/2) && mouseX <= pos.x+size.x && mouseY >= pos.y-(size.y/2) && mouseY <= pos.y+(size.y/2)) {
      return true;
    } else {
      return false;
    }
  }
  void display() {
    noStroke();
    fill(0, 0, 80);
    rect(pos.x, pos.y, size.x, size.y);
    if (over || locked) {
      fill(0, 0, 20);
    } else {
      fill(0, 0, 40);
    }
    rect(sPos.x, sPos.y, sSize.x, sSize.y);
  }
  float getPos(int min, int max){
   return map(sPos.x, minPos, maxPos, min, max);
  }
  void changeX(float sXPos){
    sPos.y = pos.y;
    sPos.x = sXPos;
    sSize.x = size.x/16;
    sSize.y = size.y;
    newPos = sPos;
  }
  void changePos(float sXPos){
    changeX(sXPos);
  }
}