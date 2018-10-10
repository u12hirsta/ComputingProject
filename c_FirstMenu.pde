class Main { // The class which holds the main menu
  int noButts = 2;
  boolean pop = false;
  Button popup;
  Button[] buttons = new Button[noButts]; 
  String[] buttonText = {"Go", "Quit"};
  Main() {
    for (int i = 0; i<noButts; i++) {
      buttons[i] = new Button(new PVector(width*0.5, height*(0.3*(i+1))), new PVector(width*0.2, height*0.15), buttonText[i]); // Creates the buttons
    }
    popup = new Button(new PVector(width*0.9, height*0.9), new PVector(height*0.1, height*0.1), "?");
  }

  void display() {
    background(0);
    for (int i = 0; i<noButts; i++) {
      fill(0, 0, 100);
      buttons[i].display(); 
      if (!pop) {
        buttons[i].hover();
      }
    }
    fill(0, 0, 100);
    popup.display();
    popup.hover();
    if (pop) {
      infoPop.display();
    }
    clickCheck();
  }

  void clickCheck() {
    if (buttons[0].clicked()) {
      main = false;
      sim = true;
    } else if (buttons[1].clicked()) {
      exit();
    }
    if (popup.clicked() && !pop){
      pop = true;
      delay(150);
    }else if (popup.clicked() && pop){
     pop = false; 
     delay(150);
    }
  }
}
