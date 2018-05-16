class Main {
  int noButts = 3;
  Button[] buttons = new Button[noButts]; 
  Main() {
    for (int i = 0; i<noButts; i++) {
      buttons[i] = new Button(width*0.35, height*(0.25*(i+1)), width*0.3, height*0.15);
    }
  }
  void display() {
    background(0);
    for (int i = 0; i<noButts; i++){
     buttons[i].display(); 
    }
  }

}