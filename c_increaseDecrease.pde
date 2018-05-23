class IncreaseDecrease {
  float y;
  int noButts = 2;
  int val;
  String firstText, value;
  Button[] buttons = new Button[noButts];
  IncreaseDecrease(float y, int val) {
    this.y = y;
    this.val = val;
    for (int i = 0; i < noButts; i++) {
      buttons[i] = new Button(new PVector(i==0?width*0.4:width*0.6, y), new PVector(width*0.1, height*0.05), "");
    }
  } 
  void display() {

    for (int i = 0; i < noButts; i++) {
      fill(i==0?255:0, i==0?0:255, 0);
      buttons[i].display();
      buttons[i].hover();
    }
  }
  void increase(int bactNo) {
    if (buttons[1].clicked()) {
      bacts.get(bactNo).increase(val);
    } else if (buttons[0].clicked()) {
      bacts.get(bactNo).decrease(val);
    }
  }
  void textDisplay(String firstText, String value) {
    fill(255);
    textSize(30);
    text(value, width*0.8, y);
    text(firstText, width*0.15, y);
  }
}