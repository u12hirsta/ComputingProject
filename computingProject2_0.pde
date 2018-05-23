// Computing project version 2.0
boolean main = true;
boolean sim = false;
<<<<<<< HEAD
boolean settings = false;
boolean setted = false;
Main mainMen;
Simulation simulation;
Settings setting;
=======
int noBacts = 20;
Main mainMen;
Simulation simulation;
ArrayList<Bact> bacts = new ArrayList<Bact>();
Settings settings;
>>>>>>> edc489b704e4d0d92d3e212ab0165c1e285f993b

void setup() {
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  size(600, 600);
  PFont mono = createFont("UbuntuMono.ttf", 26);
  textFont(mono);
  mainMen = new Main();


  for (int i = 0; i<noBacts; i++) {
    bacts.add(new Bact(new PVector(random(0, width), random(0, height)), new PVector(30, 30)));
  }
  settings = new Settings();
  simulation = new Simulation();
  setting  = new Settings();
}
void draw() {
  if (main) {
    mainMen.display();
  } else if (sim) {
    simulation.run();
<<<<<<< HEAD
  } else if (settings) {
    setted = true;
    setting.display();
=======
  } else {
    settings.display();
>>>>>>> edc489b704e4d0d92d3e212ab0165c1e285f993b
  }
}