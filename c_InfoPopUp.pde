class InfoPopUp {
  PVector pos;
  String displayText = "";
  int[] num;
  InfoPopUp(int[] num) { 
    this.num = num;
    pos = new PVector(width*0.5, height*0.5);
    for (int i = 0; i < num.length; i++) {
      displayText = displayText + file.read(num[i]) + "\n";
    }
  }
  void display() {
    fill(0, 0, 60);
    rect(pos.x, pos.y, width*0.8, height*0.8, width*0.1); 
    fill(0, 100, 0);
    textSize(20);
    text(displayText, pos.x, pos.y, width*0.8, width*0.8);
  }
}
