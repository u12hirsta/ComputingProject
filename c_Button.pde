class Button { // Class which perameters are passed in, so the same class can be used for different purposes.
  PVector pos, size; // Vectors because it stores x and y values together
  PVector currentSize;
  String text;
  float textSize;
  float currentTextSize;
  Button(PVector pos, PVector size, String text) { // Parameters which are passed in from when other places in the code 
    this.pos = pos;
    this.size = size;
    currentSize = size;
    this.text = text;
    textSizeScaler(text); // custom method for scaling the length of the text and font size to fit the button
    currentTextSize = textSize;
    
  }
  void filler(color col){ // Custom method for setting colour of the button
   fill(col); 
  }
  void display() { // For displaying the button
    strokeWeight(1);
    stroke(0);
    rect(pos.x, pos.y, currentSize.x, currentSize.y, CORNER_CURVE);
    fill(0);
    textSize(currentTextSize);
    text(text, pos.x, pos.y);
  }
  
  Boolean hover() {  // When the mouse is within the button it will increase in size by the constant HOVER_MULTIPLIER
    if (mouseX <= pos.x+(currentSize.x*0.5) && mouseX >= pos.x-(currentSize.y*0.5) && mouseY <= pos.y+(currentSize.y*0.5) && mouseY >= pos.y-(currentSize.y*0.5)) {
      currentSize = PVector.mult(size, HOVER_MULTIPLIER);
      return true;
    } else {
      currentSize = size;
      currentTextSize = textSize;
      return false;
    }
  }  
  Boolean clicked(){ // Checks if the button is clicked and returns a boolean, so you can have custom actions for hte button
    if (mouseX <= pos.x+(currentSize.x*0.5) && mouseX >= pos.x-(currentSize.y*0.5) && mouseY <= pos.y+(currentSize.y*0.5) && mouseY >= pos.y-(currentSize.y*0.5) && mousePressed) {
      return true;
    } else {
      return false;
    }
  }
  
  void textSizeScaler(String text){ // custom method for scaling the text
    textSize = text.length()<10?size.x/(text.length()):((size.x/text.length())*2);
  }
}
