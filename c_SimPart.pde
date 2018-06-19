class Simulation {
  Button menu = new Button(new PVector(width*0.05, height*0.025), new PVector(width*0.1, height*0.05), "Menu");
  
  Simulation() {

  }
  void run() {
    background(0);
    
    
    for (int i = 0; i<noBacts; i++) {
      bacts.get(i).display();
      bacts.get(i).move();
      bacts.get(i).breedCheck();
      bacts.get(i).sizeChange();
    }
    for (int i = 0; i<noBacts; i++) {
      if(bacts.get(i).size.x <= 1){
       bacts.remove(i); 
       noBacts--;
      }
    }
    if(menu.clicked()){
      main = true;
      sim = false;
    }
    fill(0, 0, 100);
    menu.display();
    menu.hover();
  }
}