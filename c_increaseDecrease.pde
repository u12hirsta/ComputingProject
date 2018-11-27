class IncreaseDecrease { // The class which holds the dna name, and value and has the scroll bar as well
  float y;
  ScrollBar scroll;
  String firstText, value;
  int bactNo;
  float x;
  int val;
  IncreaseDecrease(float y, int val) {
    this.y = y;
    this.x = width*0.85;
    this.val = val;
    scroll = new ScrollBar(new PVector(x, y+height*(0.0125))
      , new PVector(width*0.25, height*0.025), map(bacts.get(bactNo).dna[val], 0, 100, x-width*0.125, x+width*0.125));
  } 
  void display() {
    bactNo = sliderHolder.bactNum;
    scroll.display();
    scroll.update();
  }
  void changeSlide() {
    scroll.changePos(map(bacts.get(bactNo).dna[val], 0, 100, x-width*0.125, x+width*0.125));
  }
  void increase(int val) {
    bacts.get(bactNo).dna[val] = int(scroll.getPos(0, 100));
    bacts.get(bactNo).change();
  }
  void textDisplay(String firstText, String value) {
    fill(0, 0, 100);
    textSize(30);
    text(value, x+width*0.14, y);
    text(firstText, x-width*0.20, y);
  }
}
