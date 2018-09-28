class Main { // The class which holds the main menu
  int noButts = 2;
  Button[] buttons = new Button[noButts]; 
  String[] buttonText = {"Go", "Quit"};
  Main() {
    for (int i = 0; i<noButts; i++) {
      buttons[i] = new Button(new PVector(width*0.5, height*(0.3*(i+1))), new PVector(width*0.2, height*0.15), buttonText[i]); // Creates the buttons
    }
  }
  
  void display() {
    background(0);
    for (int i = 0; i<noButts; i++) {
      fill(0, 0, 100);
      buttons[i].display(); 
      buttons[i].hover();
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
  }
}
