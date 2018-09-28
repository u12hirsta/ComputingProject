class SliderHolder { // This is called in the simulation part, it is where the dna sliders are held
  boolean changed = true;
  int noSliders = bacts.get(0).dna.length;
  int bactNum = 0;
  IncreaseDecrease[] slider = new IncreaseDecrease[noSliders];
  SliderHolder() {
    for (int i = 0; i<noSliders; i++) {
      slider[i] = new IncreaseDecrease(height*(i*(1f/noSliders))+(height*(1f/noSliders))/4, i);
    }
  }
  void display() {
    changed = false;
    for (int i  = 0; i<noSliders; i++) {
      slider[i].display();
      slider[i].increase(i);
      slider[i].textDisplay(bacts.get(bactNum).dnaText[i], str(bacts.get(bactNum).dna[i]));
    }
    for(int i = 0; i < bacts.size(); i++){
     if(i == bactNum){
      bacts.get(i).selected = true;
     }else{
       bacts.get(i).selected = false;
     }
    }
  }
}
