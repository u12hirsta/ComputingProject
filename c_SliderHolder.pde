class SliderHolder {
  int noSliders = bacts.get(0).dna.length-2;
  int bactNum = 0;
  int noButtons = 4;
  Button[] buttons = new Button[noButtons];
  IncreaseDecrease[] slider = new IncreaseDecrease[noSliders];
  SliderHolder() {
    for (int i = 0; i<noSliders; i++) {
      slider[i] = new IncreaseDecrease(height*(i*(1f/noSliders))+(height*(1f/noSliders))/4, i);
    }
    buttons[0] = new Button(new PVector(width*(0.4), height*0.03), new PVector(height*0.05, height*0.05), "-");
    buttons[1] = new Button(new PVector(width*(0.5), height*0.03), new PVector(height*0.05, height*0.05), "+");
  }
  void display() {
    if (buttons[0].clicked() && bactNum > 0) {
      bactNum--;
      delay(10);
    } 
    if (buttons[1].clicked() && bactNum < noBacts-1) {
      bactNum++;
      delay(10);
    }
    for (int i  = 0; i<noSliders; i++) {
      slider[i].display();
      slider[i].increase(i);
      slider[i].textDisplay(bacts.get(bactNum).dnaText[i], str(bacts.get(bactNum).dna[i]));
    }
    text(bactNum, width*0.45, height*0.03);

    for (int i = 0; i <2; i++) {
      fill(0, 0, 100);
      buttons[i].hover();
      buttons[i].display();
    }
    for(int i = 0; i < noBacts; i++){
     if(i == bactNum){
      bacts.get(i).selected = true;
     }else{
       bacts.get(i).selected = false;
     }
    }
  }
}