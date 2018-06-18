class IncreaseDecrease {
  float y;
  //int noButts = 2;
  //int val;
  ScrollBar scroll;
  String firstText, value;
  int bactNo;
  //Button[] buttons = new Button[noButts];
  IncreaseDecrease(float y, int val, int bactNo) {
    this.y = y;
//    this.val = val;
    this.bactNo = bactNo;
    scroll = new ScrollBar(new PVector(width*0.5, y+height*(0.0125))
    , new PVector(width*0.25, height*0.025), map(bacts.get(bactNo).dna[val], 0, 100, width*0.5, width*0.625));
  
  } 
  void display() {
    scroll.display();
    scroll.update();
  }
  void increase(int val) {
    bacts.get(bactNo).dna[val] = int(scroll.getPos(0, 100));
    bacts.get(bactNo).change();
  }
  void textDisplay(String firstText, String value) {
    fill(255);
    textSize(30);
    text(value, width*0.8, y);
    text(firstText, width*0.15, y);
  }
}