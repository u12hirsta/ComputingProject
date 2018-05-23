class Simulation {
  Button menu = new Button(new PVector(width*0.05, height*0.025), new PVector(width*0.1, height*0.05), "Menu");
  
  Simulation() {

  }
  void run() {
    background(0);
    fill(255);
    menu.display();
    menu.hover();
    for (int i = 0; i<noBacts; i++) {
      bacts.get(i).display();
      bacts.get(i).move();
    }
    if(menu.clicked()){
      main = true;
      sim = false;
    }
  }
  void bactCollision() {
    for (int i = 0; i<noBacts; i++) {
      for (int j = 1; j<noBacts; j++) {
        bacts.get(i).collide(bacts.get(j));
      }
    }
  }
}