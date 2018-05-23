class Settings {
<<<<<<< HEAD
  int noButts = 3;
  Button[] buttons = new Button[noButts]; 
  String[] buttonText = {"Go", "Set values", "Exit"};
  Settings() {
    for (int i = 0; i<noButts; i++) {
      buttons[i] = new Button(new PVector(width*0.5, height*(0.3*(i+1))), new PVector(width*0.2, height*0.1), buttonText[i]);
=======
  int noTabs = 1;
  int bactNo = 0;
  IncreaseDecrease[] tabs = new IncreaseDecrease[noTabs];
  Button menu = new Button(new PVector(width*0.05, height*0.025), new PVector(width*0.1, height*0.05), "Menu");
  Settings() {
    for (int i = 0; i<noTabs; i++) {
      tabs[i] = new IncreaseDecrease(height*(0.2*(i+1)), 0);
>>>>>>> edc489b704e4d0d92d3e212ab0165c1e285f993b
    }
  }
  void display() {
    background(0);
<<<<<<< HEAD
    for (int i = 0; i<noButts; i++) {
      buttons[i].display(); 
      buttons[i].hover();
    }
    clickCheck();
  }
  void clickCheck() {
    if (buttons[0].clicked()) {
      
    } else if (buttons[1].clicked()) {
      
    } else if (buttons[2].clicked()) {
      
=======
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
>>>>>>> edc489b704e4d0d92d3e212ab0165c1e285f993b
    }
  }
}