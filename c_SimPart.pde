class Simulation {
  int noBacts = 20;
  Button menu = new Button(new PVector(width*0.05, height*0.025), new PVector(width*0.1, height*0.05), "Menu");
  ArrayList<Bact> bacts = new ArrayList<Bact>();
  Simulation() {
    for (int i = 0; i<noBacts; i++) {
      bacts.add(new Bact(new PVector(random(0, width), random(0, height)), new PVector(30, 30)));
    }
  }
  void run() {
    background(0);
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
  void ballCollision() {
    for (int i = 0; i<noBacts; i++) {
      for (int j = 1; j<noBacts; j++) {
        bacts.get(i).collide(bacts.get(j));
      }
    }
  }
}