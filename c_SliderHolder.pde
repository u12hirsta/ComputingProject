class SliderHolder {
  int noSliders = bacts.get(0).dna.length;
  int bactNum = 0;
  IncreaseDecrease[] slider = new IncreaseDecrease[noSliders];
  SliderHolder() {
    for (int i = 0; i<noSliders; i++) {
      slider[i] = new IncreaseDecrease(height*(i*(1f/noSliders))+(height*(1f/noSliders))/4, i);
    }
  }
  void display() {
    for (int i  = 0; i<noSliders; i++) {
      slider[i].display();
      slider[i].increase(i);
      slider[i].textDisplay(bacts.get(bactNum).dnaText[i], str(bacts.get(bactNum).dna[i]));
    }
  }
}