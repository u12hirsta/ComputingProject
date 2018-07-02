class Button {
  PVector pos, size;
  PVector currentSize;
  String text;
  float textSize;
  float currentTextSize;
  Button(PVector pos, PVector size, String text) {
    this.pos = pos;
    this.size = size;
    currentSize = size;
    this.text = text;
    textSizeScaler(text);
    currentTextSize = textSize;
    
  }
  void filler(color col){
   fill(col); 
  }
  void display() {
    strokeWeight(1);
    stroke(0);
    rect(pos.x, pos.y, currentSize.x, currentSize.y, CORNER_CURVE);
    fill(0);
    textSize(currentTextSize);
    text(text, pos.x, pos.y);
  }
  
  Boolean hover() {
    if (mouseX <= pos.x+(currentSize.x*0.5) && mouseX >= pos.x-(currentSize.y*0.5) && mouseY <= pos.y+(currentSize.y*0.5) && mouseY >= pos.y-(currentSize.y*0.5)) {
      currentSize = PVector.mult(size, HOVER_MULTIPLIER);
      return true;
    } else {
      currentSize = size;
      currentTextSize = textSize;
      return false;
    }
  }
  
  Boolean clicked(){
    if (mouseX <= pos.x+(currentSize.x*0.5) && mouseX >= pos.x-(currentSize.y*0.5) && mouseY <= pos.y+(currentSize.y*0.5) && mouseY >= pos.y-(currentSize.y*0.5) && mousePressed) {
      return true;
    } else {
      return false;
    }
  }
  
  void textSizeScaler(String text){
    textSize = text.length()<10?size.x/(text.length()):((size.x/text.length())*2);
  }
}