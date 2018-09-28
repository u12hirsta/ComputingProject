// Computing project version 2.0
boolean main = true; // checking which part of the system they are on
boolean sim = false;

Main mainMen;  // Defining of class of each part of the program
Simulation simulation; // Main sim
SliderHolder sliderHolder; // Where the sliders are help

//int noNutrients = 100;
int noFood = 20;

//ArrayList<Nutrients> nutrients = new ArrayList<Nutrients>();
ArrayList<Bact> bacts = new ArrayList<Bact>(); // Bacteria is an array list because they can have the size changed
ArrayList<Food> food = new ArrayList<Food>();

//int var1, var2, var3;
void settings() { // settings is only run at start
  fullScreen(); // Makes the canvas full screen
}

void setup() { // Only calls once, after settings is called
  strokeWeight(1);
  PFont mono = createFont("UbuntuMono.ttf", 26); // sets the text font to a mono because all the letters all the same length 
  textFont(mono); //which means I can scale the text size compared to the length of the text
  for (int i = 0; i<20; i++) {
    bacts.add(new Bact(new PVector(random(0, width), random(0, height)))); // Adds the first new bacteria in a random position
  }
  for (int i = 0; i<noFood; i++) {
    float foodSize = random(0, height*0.1);
    food.add(new Food(new PVector(random(0, width*0.55), random(0, height*0.55)), new PVector(foodSize,foodSize))); // Adds the first new bacteria in a random position
  }
  surface.setResizable(false);
  colorMode(HSB, 360, 100, 100); // Using HSB rather than RGB because HSB means I only need to change one parameter to make the colour change
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  sliderHolder = new SliderHolder(); // Calling the classes
  mainMen = new Main();
  simulation = new Simulation();
  //for (int i = 0; i<noNutrients; i++) {
  //  nutrients.add(new Nutrients(int(random(9)), new PVector(random(width*0.60 ), random(height)), random(5, 30)));
  //}
}

void draw() { // Draw is run every frame
  if (main) {
    mainMen.display();
  } else if (sim) {
    simulation.run();
  }
}
