class Simulation {
  Button menu = new Button(new PVector(width*0.05, height*0.025), new PVector(width*0.1, height*0.05), "Menu");

  float temperature = random(-50, 100);
  ScrollBar tempSlide = new ScrollBar(new PVector(width*0.6, height*0.95), new PVector(width*0.2, height*0.05), map(temperature, -50, 100, width*0.5, width*0.7));
  Simulation() {
    
  }
  void run() {
    background(map(temperature, -50, 100, 180, 360), 100, 75);
    
    
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
    tempSlide.display();
    tempSlide.update();
    fill(0, 0, 100);
    
    text("Temperature: "+ str(round(temperature)) + "ºC", width*0.85, height*0.95);
    temperature = tempSlide.getPos(-50, 100);
    temperature = map(noise(frameCount*0.01),0,1,-50,100);
  }
} //<>//