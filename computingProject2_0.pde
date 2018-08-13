// Computing project version 2.0
boolean main = true;
boolean sim = false;

Main mainMen;
Simulation simulation;
SliderHolder slider;
int noBacts = 20;
int noNutrients = 100;


ArrayList<Nutrients> nutrients = new ArrayList<Nutrients>();
ArrayList<Bact> bacts = new ArrayList<Bact>();


//int var1, var2, var3;
void settings(){
  size(1200, 600, FX2D);

}

void setup() {
  strokeWeight(1);
  PFont mono = createFont("UbuntuMono.ttf", 26);
  textFont(mono);
  for (int i = 0; i<noBacts; i++) {
    bacts.add(new Bact(new PVector(random(0, width), random(0, height))));
  }
  surface.setResizable(false);
  colorMode(HSB, 360, 100, 100);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  slider = new SliderHolder();
  mainMen = new Main();
  simulation = new Simulation();
  for(int i = 0; i<noNutrients; i++){
    nutrients.add(new Nutrients(0/*int(random(9))*/, new PVector(random(width*0.75), random(height)), random(5, 30)));
  }
  nutrients.get(nutrients.size()-1).type = 5;
}

void draw() {
  frameRate(60);
  for(int i = 0; i < noBacts; i++){
   bacts.get(i).move(); 
  }
  if (main) {
    mainMen.display();
  } else if (sim) {
    simulation.run();
  }
  text(frameRate, width*0.9, height*0.1);
  for (int i = 0; i<noBacts; i++) {
    if (bacts.get(i).size.x <= 0.99) {
      bacts.remove(i);
      noBacts--;
    }
  }
}