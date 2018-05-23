class Settings {
  int noTabs = 1;
  int bactNo = 0;
  IncreaseDecrease[] tabs = new IncreaseDecrease[noTabs];
  Button menu = new Button(new PVector(width*0.05, height*0.025), new PVector(width*0.1, height*0.05), "Menu");
  Settings() {
    for (int i = 0; i<noTabs; i++) {
      tabs[i] = new IncreaseDecrease(height*(0.2*(i+1)), 0);
    }
  }
  void display() {
    background(0);
    for (int i = 0; i<noTabs; i++) {
      tabs[i].display();
      tabs[i].increase(bactNo);
      tabs[i].textDisplay("Test", bacts.get(i).define(bacts.get(bactNo).dna[0]));
    }
    fill(255);
    menu.display();
    menu.hover();  
    if (menu.clicked()) {
      main = true;
      sim = false;
    }
  }
}