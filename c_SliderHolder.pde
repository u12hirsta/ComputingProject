class SliderHolder {
  int noSliders = bacts.get(0).dna.length;
  int bactNum = 0;
  int noButtons = 4;
  Button[] buttons = new Button[noButtons];
  IncreaseDecrease[] slider = new IncreaseDecrease[noSliders];
  SliderHolder() {
    for (int i = 0; i<noSliders; i++) {
      slider[i] = new IncreaseDecrease(height*(i*(1f/noSliders))+(height*(1f/noSliders))/4, i);
    }

    buttons[0] = new Button(new PVector(width*0.4, height*0.03), new PVector(height*0.05, height*0.05), ""); 
    buttons[0].filler(color(100, 50, 50));
  }
  void display() {
    for (int i  = 0; i<noSliders; i++) {
      slider[i].display();
      slider[i].increase(i);
      slider[i].textDisplay(bacts.get(bactNum).dnaText[i], str(bacts.get(bactNum).dna[i]));
    }
    buttons[0].display();
  }
}