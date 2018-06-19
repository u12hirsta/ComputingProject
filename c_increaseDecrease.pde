class IncreaseDecrease {
  float y;
  ScrollBar scroll;
  String firstText, value;
  int bactNo;
  IncreaseDecrease(float y, int val) {
    this.y = y;
    scroll = new ScrollBar(new PVector(width*0.5, y+height*(0.0125))
    , new PVector(width*0.25, height*0.025), map(bacts.get(bactNo).dna[val], 0, 100, width*0.375, width*0.625));
  
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
    fill(0, 0, 100);
    textSize(30);
    text(value, width*0.8, y);
    text(firstText, width*0.15, y);
  }
}