// Constants used for easy changing if needed to.
// Also so they won't be changed in multiple different places
// Also so that they won't be accidentally changed differently in different places
final float MAX_TURN_AMOUNT = HALF_PI;
final int MAX_TURN_TIMER = 60;
final int MIN_TURN_TIMER = 1;
final float MIN_BACTERIA_VEL = 1.0;
final float MAX_BACTERIA_VEL = 2.5;
final int MIN_HUNGER = 8000;
final int MAX_HUNGER = 15000;
final float MIN_META = 0.90;
final float MAX_META = 0.99;
final float MIN_DIAMETER = 20;
final float MAX_DIAMETER = 30;


// Bacteria number and diameter will change depending on the size of the canvas
// So they aren't constants
int bactNumber;
int bacteriaRadius;
int maxFood = int(random(20, 75));

// allDead boolean is used to check whether all of the bacteria are dead
// If they are all dead then the simulation will end
boolean allDead = false;
boolean allInfect = true;
boolean display = false;
boolean move = true;
boolean menuOpen = false;

Button[] button = new Button[8];
// ArrayList which stores all the bacteria because you can remove items
// From the list and the list changes size.
ArrayList<Bacteria> bacteria = new ArrayList<Bacteria>();

// ArrayList for food because it will be eaten and then removed from the canvas and ArrayList completely
ArrayList<Food> food = new ArrayList<Food>();


// Settings done so if I wanted to change the size then I could
void settings() {
  size(600, 600);
}

void setup() {
  // The number of bacteria is equal to an 8th of the width 
  // So that when there is a smaller width the canvas is not really crowded.
  bactNumber = round(width/random(16, 32)); 
  // The size of the bacteria is also proportional to the width because as the canvas decreases 
  // So will the radius
  bacteriaRadius = width/32;
  // The bacteria are drawn on the canvas in the reset function
  reset(bactNumber);
  PFont mono = createFont("UbuntuMono.ttf", 26);
  textFont(mono);
  textSize(height*0.024);
}

void draw() {
  // All infected is assumed to be true unless stated overwise
  allInfect = true;
  // Black background
  background(0);
  // Creates food and puts them into the canvas
  if(food.size() <= maxFood){
    for (int i = 0; i <= maxFood-food.size(); i++){
      food.add(new Food(random(0, width), random(0, height), random(round(width/100), round(width/50))));
    }
  }
  // Displays food
  for (int i = 0; i < food.size(); i++) {
    food.get(i).display();
  }
  // Checking whether a piece of food has been eaten
  for (int i = 0; i < food.size(); i++){
   if(food.get(i).eaten == true){
    food.remove(i); 
   }
  }
  // For every bacteria in the ArrayList it will run them and make them move
  for (int i = 0; i < bacteria.size(); i++) {
    bacteria.get(i).run();
  }
  // For every bacteria and every other bacteria it will run the function collide
  // in the class to check whether they have collided.
  for (int i = 0; i < bacteria.size(); i++) {
    for (int j = i+1; j < bacteria.size(); j++) {
      bacteria.get(i).collide(bacteria.get(j));
    }
  }
  // Checks every bacteria is touching any food
  for (int i = 0; i < bacteria.size(); i++){
   for (int j  = 0; j <food.size(); j++){
     bacteria.get(i).eat(food.get(j));
   }
  }
  // For every bacteria, it will call the display function and display the bacteria
  for (int i = 0; i < bacteria.size(); i++) {
    bacteria.get(i).display();
  }
  // When all the bacteria are dead it will reset the simulation with the bacteria number
  if (bacteria.size() == 0) {
    reset(bactNumber);
  }
  // If all of the bacteria are infected then it will reset the simulation
  if (allInfect) {
    reset(bactNumber);
  }
  // If the hunger is less than 0.01 then the bacteria will be removed from the canvas
  for (int i = bacteria.size()-1; i >= 0; i--) {
    if (bacteria.get(i).hunger <= 0.1) {
      bacteria.remove(i);
    }
  }
  if (display){
    for (int i = bacteria.size()-1; i >= 0; i--) {
     bacteria.get(i).data();
    }
  }
  fill(255);
  text(frameRate, 100, 100);
}

void keyPressed() {
  // Force reset
  if (key == ' ') {
    reset(bactNumber);  
  }
  if (key == 'F' || key == 'f'){
   maxFood += 1;
   maxFood = constrain(maxFood, 0, 100);
  }
  if (key == 'g' || key == 'G'){
   maxFood -= 1;
   maxFood = constrain(maxFood, -1, 100);
  }
  if (key == 'd' || key == 'D'){
   display = !display;
  }
}

// Reset function, will create the bacteria and add them to the list
void reset(int NUMBER_OF_BACTERIA) {
  bacteria = new ArrayList<Bacteria>();
  for (int i = 0; i < NUMBER_OF_BACTERIA; i++) {
    bacteria.add(new Bacteria(random(0, width), random(0, height)));
  }
  food = new ArrayList<Food>();
  bacteria.get(0).severity = 0.1;
}

void mousePressed(){
 for(int i = 0; i<bacteria.size(); i++){
  bacteria.get(i).clicked(); 
 }
}