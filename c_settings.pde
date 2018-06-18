class Settings {
  final int NO_TABS = 4;
  int bactNo = 0;
  int noButts = 2;
  Button[] change = new Button[noButts];
  IncreaseDecrease[] tabs = new IncreaseDecrease[NO_TABS];
  Button menu = new Button(new PVector(width*0.05, height*0.025), new PVector(width*0.1, height*0.05), "Menu");
  Settings() {
    for (int i = 0; i <noButts; i++) {
      change[i] = new Button(new PVector(width*(0.70+(0.2*i)), height*0.03), new PVector(height*0.05, height*0.05), "");
    }
    create();
  }
  void display() {
    background(0);
    for (int i = 0; i < noButts; i++) {
      fill(255);
      change[i].display();
      change[i].hover();
    }
    fill(255);
    textSize(30);
    text(bactNo, width*0.8, height*0.03);
    clickCheck();
  }
  void clickCheck() {

    for (int i = 0; i<NO_TABS; i++) {
      tabs[i].display();
      tabs[i].increase(i);
      tabs[i].textDisplay(bacts.get(bactNo).dnaText[i], bacts.get(bactNo).define(bacts.get(bactNo).dna[i]));
    }
    fill(255);
    menu.display();
    menu.hover();  
    if(change[0].clicked() && bactNo >= 1){
      bactNo--;
      for(int i = 0; i<NO_TABS; i++){
        tabs[i].scroll.changeX(map(bacts.get(bactNo).dna[0], 0, 100, width*0.5, width*0.625));
      }
    }else if(change[1].clicked() && bactNo < noBacts-1){
     bactNo++; 
    }
    if (menu.clicked()) {
      main = true;
      sim = false;
    }
  }
  void create() {
    for (int i = 0; i<NO_TABS; i++) {
      tabs[i] = new IncreaseDecrease(height*((1f/(NO_TABS))*(i+0.5)), i, bactNo);
    }
  }
}