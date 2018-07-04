class Simulation { //<>//
  Button menu = new Button(new PVector(width*0.05, height*0.025), new PVector(width*0.1, height*0.05), "Menu");

  float temperature = random(-50, 100);
  ScrollBar tempSlide = new ScrollBar(new PVector(width*0.6, height*0.95), new PVector(width*0.2, height*0.05), map(temperature, -50, 100, width*0.5, width*0.7));
  Simulation() {
  }
  void run() {
    strokeWeight(1);
    background(0, 0, 20);
    for (int i = 0; i < noNutrients; i++) {
      nutrients.get(i).display();
    }

    for (int i = 0; i<noBacts; i++) {
      bacts.get(i).display();
      bacts.get(i).move();
      bacts.get(i).breedCheck();
      bacts.get(i).sizeChange();
    }
    for (int i = 0; i<noBacts; i++) {
      if (bacts.get(i).size.x <= 1) {
        bacts.remove(i); 
        noBacts--;
      }
    }
    if (menu.clicked()) {
      main = true;
      sim = false;
    }
    fill(0, 0, 100);
    menu.display();
    menu.hover();
    tempSlide.display();
    tempSlide.update();
    fill(0, 0, 100);
    if (temperature > -20) {
      for (int i = 0; i < noBacts; i++) {
        bacts.get(i).frozen = false;
      }
    } else if (temperature < -20) {
      for (int i = 0; i < noBacts; i++) {
        bacts.get(i).frozen = true;
      }
    }
    text("Temperature: "+ str(round(temperature)) + "ºC", width*0.85, height*0.95);
    //temperature = temperature+map(noise(frameCount*0.0001),0,1,-50,100);
    //tempSlide.changeX(map(temperature, -50, 100, width*0.5, width*0.7));
    temperature = tempSlide.getPos(-50, 100);
    for (int i = noNutrients-1; i >= 0; i--) {
      for (int j = 0; j < noBacts; j++) {
        if(PVector.dist(bacts.get(j).pos,
        nutrients.
        get(
        i).
        pos) 
        <
        (bacts.get(j).size.x/2)+
        (nutrients.get(i).size.x/2)){
          bacts.get(j).nutrientsCollide(nutrients.get(i));
          nutrients.remove(i);
          noNutrients--;
        }
      }
    }
  }
}