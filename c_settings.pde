class Settings {
  final int NO_TABS = 7;
  int bactNo = 0;
  int noButts = 2;
  int increaseDecreaseBtn = 2;
  Button[] change = new Button[noButts];
  //boolean[] clicked = new boolean[NO_TABS];
  //Button[] clickAll = new Button[NO_TABS];
  Button[] changeNoBacts = new Button[increaseDecreaseBtn];
  IncreaseDecrease[] tabs = new IncreaseDecrease[NO_TABS];
  Button menu = new Button(new PVector(width*0.05, height*0.025), new PVector(width*0.1, height*0.05), "Menu");
  Settings() {
    for (int i = 0; i <noButts; i++) {
      change[i] = new Button(new PVector(width*(0.70+(0.2*i)), height*0.03), new PVector(height*0.05, height*0.05), "");
    }
    for (int i = 0; i <increaseDecreaseBtn; i++) {
      changeNoBacts[i] = new Button(new PVector(width*(0.2+(0.2*i)), height*0.025), new PVector(height*0.05, height*0.05), i==0?"-":"+");
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

      fill(0, 0, 100);
      change[i].display();
      change[i].hover();
    }
    for (int i = 0; i < increaseDecreaseBtn; i++) {
      fill(0, 0, 100);
      changeNoBacts[i].display();
      changeNoBacts[i].hover();
    }
    fill(0, 0, 100);
    textSize(14);
    text("Add/\nRemove bacteria", width*0.3, height*0.04);
    text("Number of bacteria = " + noBacts, width*0.8, height*0.95);
    bacts.get(bactNo).display();
    //for (int i = 0; i < NO_TABS; i++) {
    //  if (clicked[i]) {
    //    clickAll[i].filler(color(200, 255, 255));
    //  }else{
    //   clickAll[i].filler(color(0, 255, 255)); 
    //  }
    //  clickAll[i].display();
    //  clickAll[i].hover();


    //}
    fill(0, 0, 100);
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
    if (changeNoBacts[0].clicked() && bacts.size() > 1) {
      noBacts--;
      bacts.remove(bactNo); 
      delay(50);
    } else if (changeNoBacts[1].clicked() ){
      noBacts++;
      bacts.add(new Bact(new PVector(random(width), random(height)))); 
      delay(50);
    }
    fill(0, 0, 100);
    menu.display();
    menu.hover();  
    if (change[0].clicked() && bactNo >= 1) {
      bactNo--;
      delay(100);
      for (int i = 0; i<NO_TABS; i++) {
        tabs[i].bactNo = this.bactNo;
        tabs[i].scroll.changeX(map(bacts.get(bactNo).dna[i], 0, 100, width*0.375, width*0.625));
      }
    } else if (change[1].clicked() && bactNo < noBacts-1) {
      bactNo++; 
      delay(100);
      for (int i = 0; i<NO_TABS; i++) {
        tabs[i].bactNo = this.bactNo;
        tabs[i].scroll.changeX(map(bacts.get(bactNo).dna[i], 0, 100, width*0.375, width*0.625));
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
  void changeSlider() {
    for (int i = 0; i<NO_TABS; i++) {
      tabs[i].scroll.changeX(map(bacts.get(bactNo).dna[i], 0, 100, width*0.375, width*0.625));
    }
  }
}