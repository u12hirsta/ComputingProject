class Simulation {
  Button menu = new Button(new PVector(width*0.05, height*0.025), new PVector(width*0.1, height*0.05), "Menu");

  float temperature = random(-50, 100);
  ScrollBar tempSlide = new ScrollBar(new PVector(width*0.6, height*0.95), new PVector(width*0.2, height*0.05), map(temperature, -50, 100, width*0.5, width*0.7));
  Simulation() {
    
  }
  void run() {
    background(0, 100, 0);
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
    if(temperature > 50){
      for(int i = 0; i < noBacts; i++){
       bacts.get(i).frozen = false;
      }
    }else if(temperature < -20){
      for(int i = 0; i < noBacts; i++){
       bacts.get(i).frozen = true;
      }
    }
    text("Temperature: "+ str(round(temperature)) + "ºC", width*0.85, height*0.95);
    //temperature = temperature+map(noise(frameCount*0.0001),0,1,-50,100);
    //tempSlide.changeX(map(temperature, -50, 100, width*0.5, width*0.7));
    temperature = tempSlide.getPos(-50, 100);
    
    
  }
} //<>//