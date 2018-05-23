// Computing project version 2.0
boolean main = true;
boolean sim = false;
int noBacts = 20;
Main mainMen;
Simulation simulation;
ArrayList<Bact> bacts = new ArrayList<Bact>();
Settings settings;

void setup() {
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  size(600, 600);
  PFont mono = createFont("UbuntuMono.ttf", 26);
  textFont(mono);
  mainMen = new Main();


  for (int i = 0; i<noBacts; i++) {
    bacts.add(new Bact(new PVector(random(0, width), random(0, height))));
  }
  settings = new Settings();
  simulation = new Simulation();
}
void draw() {
  if (main) {
    mainMen.display();
  } else if (sim) {
    simulation.run();
  } else {
    settings.display();
  }
}