class Settings {
  final int NO_TABS = 4;
  int bactNo = 0;
  int noButts = 2;
  Button[] change = new Button[noButts];
  //boolean[] clicked = new boolean[NO_TABS];
  //Button[] clickAll = new Button[NO_TABS];
  IncreaseDecrease[] tabs = new IncreaseDecrease[NO_TABS];
  Button menu = new Button(new PVector(width*0.05, height*0.025), new PVector(width*0.1, height*0.05), "Menu");
  Settings() {
    for (int i = 0; i <noButts; i++) {
      change[i] = new Button(new PVector(width*(0.70+(0.2*i)), height*0.03), new PVector(height*0.05, height*0.05), "");
    }
    //for (int i = 0; i < NO_TABS; i++) {
    //  clickAll[i] = new Button(new PVector(width*0.9, height*((1f/(NO_TABS))*(i+0.5))), new PVector(width*0.05, height*0.05 ), "");
    //  clicked[i] = false;
    //}
    create();
  }
  void display() {
    background(0);
    for (int i = 0; i < noButts; i++) {

      fill(255);
      change[i].display();
      change[i].hover();
    }
    //for (int i = 0; i < NO_TABS; i++) {
    //  if (clicked[i]) {
    //    clickAll[i].filler(color(200, 255, 255));
    //  }else{
    //   clickAll[i].filler(color(0, 255, 255)); 
    //  }
    //  clickAll[i].display();
    //  clickAll[i].hover();


    //}
    fill(255);
    textSize(30);
    text(bactNo+1, width*0.8, height*0.03);
    clickCheck();
  }
  void clickCheck() {
    for (int i = 0; i<NO_TABS; i++) {
      tabs[i].display();
      tabs[i].increase(i);
      tabs[i].textDisplay(bacts.get(bactNo).dnaText[i], bacts.get(bactNo).define(bacts.get(bactNo).dna[i]));
      //if (clickAll[i].clicked() && clicked[i] == false) {
      //  clicked[i] = true;
      //  delay(100);
      //} else if (clickAll[i].clicked() && clicked[i] == true) {
      //  clicked[i] = false;
      //  delay(100);
      //}
    }
    fill(255);
    menu.display();
    menu.hover();  
    if (change[0].clicked() && bactNo >= 1) {
      bactNo--;
      delay(100);
      for (int i = 0; i<NO_TABS; i++) {
        tabs[i].bactNo = this.bactNo;
        tabs[i].scroll.changeX(map(bacts.get(bactNo).dna[i], 0, 100, width*0.5, width*0.625));
      }
    } else if (change[1].clicked() && bactNo < noBacts-1) {
      bactNo++; 
      delay(100);
      for (int i = 0; i<NO_TABS; i++) {
        tabs[i].bactNo = this.bactNo;
        tabs[i].scroll.changeX(map(bacts.get(bactNo).dna[i], 0, 100, width*0.5, width*0.625));
      }
    }
    if (menu.clicked()) {
      main = true;
      sim = false;
    }
  }
  void create() {
    for (int i = 0; i<NO_TABS; i++) {
      tabs[i] = new IncreaseDecrease(height*((1f/(NO_TABS))*(i+0.5)), i);
    }
  }
}