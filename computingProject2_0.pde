// Computing project version 2.0
boolean main = true;
boolean sim = false;
boolean settings = false;
boolean setted = false;

Main mainMen;
Simulation simulation;
Settings setting;
int noBacts = 1;

ArrayList<Bact> bacts = new ArrayList<Bact>();
//int var1, var2, var3;

void setup() {
  colorMode(HSB, 360, 100, 100);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  size(600, 600);
  PFont mono = createFont("UbuntuMono.ttf", 26);
  textFont(mono);
  mainMen = new Main();
  for (int i = 0; i<noBacts; i++) {
    bacts.add(new Bact(new PVector(random(0, width), random(0, height))));
  }
  setting = new Settings();
  simulation = new Simulation();
  setting  = new Settings();
}

void draw() {
  for(int i = 0; i < noBacts; i++){
   bacts.get(i).move(); 
  }
  //var1 = int(bacts.size()*0.25);
  //var2 = int(bacts.size()*0.5);
  //var3 = int(bacts.size()*0.75);
  //thread("threaded1");
  //thread("threaded2");
  //thread("threaded3");
  //thread("threaded4");
  if (main) {
    mainMen.display();
  } else if (sim) {
    simulation.run();
  } else if (settings) {
    setting.changeSlider();
    setted = true;
    setting.display();
  } 
  text(frameRate, width*0.9, height*0.1);
  for (int i = 0; i<noBacts; i++) {
    if (bacts.get(i).size.x <= 0.99) {
      bacts.remove(i);
      noBacts--;
    }
  }
}

//void threaded1(){
//  for(int i = 0; i < var1; i++){
//    bacts.get(i).move();
//  }
//}

//void threaded2(){
//  for(int i = var1; i < var2; i++){
//    bacts.get(i).move();
//  }
//}
//void threaded3(){
//  for(int i = var2; i < var3; i++){
//    bacts.get(i).move();
//  }
//}
//void threaded4(){
//  for(int i = var3; i < bacts.size(); i++){
//    bacts.get(i).move();
//  }
//}