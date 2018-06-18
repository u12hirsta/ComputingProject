import java.util.Arrays;
// Computing project version 2.0
boolean main = true;
boolean sim = false;
boolean settings = false;
boolean setted = false;

Main mainMen;
Simulation simulation;
Settings setting;
int noBacts = 20;

ArrayList<Bact> bacts = new ArrayList<Bact>();

void setup() {
  colorMode(HSB);
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
  if (main) {
    mainMen.display();
  } else if (sim) {
    simulation.run();
  } else if (settings) {
    setted = true;
    setting.display();
  } 
  for (int i = 0; i<noBacts; i++) {
    if (bacts.get(i).size.x <= 0.99) {
      bacts.remove(i);
      noBacts--;
    }
  }
}