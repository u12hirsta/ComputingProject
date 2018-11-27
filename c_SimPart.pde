class Simulation { // The class where the bacteria are simulated from //<>//
  Button menu = new Button(new PVector(width*0.05, height*0.025), new PVector(width*0.1, height*0.05), "Menu"); 
  float temperature = random(-50, 100); // Temperature effects the bacteria's speed and growth rate
  boolean pop = false;
  ScrollBar tempSlide = new ScrollBar(new PVector(width*0.6, height*0.97), new PVector(width*0.2, height*0.05), map(temperature, -50, 100, width*0.5, width*0.7));
  Button popup;
  InfoPopUp infoPop;
  Simulation() {
    popup = new Button(new PVector(width*0.05, height*0.9), new PVector(height*0.1, height*0.1), "?");
    int[] nums = {2, 3, 4, 5};
    infoPop = new InfoPopUp(nums);
  }
  void run() {
    strokeWeight(1);
    background(0, 0, 20);
    sliderHolder.display();
    for (int i = 0; i < noFood; i++) {
      food.get(i).display();
    }
    for (int i = 0; i<bacts.size(); i++) {
      bacts.get(i).display();
      bacts.get(i).move();  // Different functions in the Bacteria class
      bacts.get(i).breedCheck();
      bacts.get(i).sizeChange();
      fill(0, 0, 100);
      popup.display();
      popup.hover();
      if (bacts.get(i).dead && bacts.size() >= 1) {
        bacts.remove(i);
      } else if (bacts.get(i).dead && bacts.size() == 1) {
        sim = false;
        main = true;
      }
      if (bacts.get(i).clicked() && mousePressed) { // If the bacteria is clicked then they can change the dna values of the bacteria
        sliderHolder.bactNum = i;
      }
    }
    for (int i = 0; i<bacts.size(); i++) {
      if (bacts.get(i).size.x <= 1) {
        if (bacts.size() == 1) {
          sim = false;
          main = true; // When the last bacteria dies the it goes back to the menu
        } else {
          if (sliderHolder.bactNum == i && i != 1 && sliderHolder.bactNum == bacts.size()) {
            sliderHolder.bactNum--; // If the bacteria dies and it is not the last one then it removes it.
          }
          bacts.remove(i);
        }
      }
    }
    if (menu.clicked()) { // If the menu button is clicked then the simulation ends and it goes back to the menu
      main = true;
      sim = false;
    }
    if (popup.clicked()&&!pop) {
      pop = true; 
      delay(150);
    } else if (popup.clicked() && pop) {
      pop = false;
      delay(150);
    }
    fill(0, 0, 100);
    menu.display();
    menu.hover();
    tempSlide.display();
    tempSlide.update();

    fill(0, 0, 100);
    if (temperature > -20) { // If the temperature is less than 20 they will freeze which will mean they won't move, breed or change size
      for (int i = 0; i < bacts.size(); i++) {
        bacts.get(i).frozen = false;
      }
    } else if (temperature < -20) {
      for (int i = 0; i < bacts.size(); i++) {
        bacts.get(i).frozen = true;
      }
    }
    text("Temperature: "+ str(round(temperature)) + "ºC", width*0.85, height*0.97);
    //temperature = temperature+map(noise(frameCount*0.0001),0,1,-50,100);
    //tempSlide.changeX(map(temperature, -50, 100, width*0.5, width*0.7));
    temperature = tempSlide.getPos(-50, 100);
    for (int j = 0; j < bacts.size(); j++) {
      for (int i = noFood-1; i >= 0; i--) {
        if (PVector.dist(bacts.get(j).pos, food.get(i).pos) <(bacts.get(j).size.x/2)+(food.get(i).size.x/2)) {
          bacts.get(j).foodCollide(food.get(i));
          food.remove(i);
          noFood--;
        }
      }
    }
    if (pop) {
      infoPop.display();
    }
  }
}
