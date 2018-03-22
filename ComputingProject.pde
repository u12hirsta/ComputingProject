// Constants used for easy changing if needed to.
// Also so they won't be changed in multiple different places
// Also so that they won't be accidentally changed differently in different places
final float MAX_TURN_AMOUNT = HALF_PI;
final int MAX_TURN_TIMER = 60;
final int MIN_TURN_TIMER = 1;
final float BACTERIA_VEL = 2.5;

// Bacteria number and diameter will change depending on the size of the canvas
// So they aren't constants
int bactNumber;
int bacteriaRadius;

// Max food is the maximum amount of food on the canvas
int maxFood = 100;


// allDead boolean is used to check whether all of the bacteria are dead
// If they are all dead then the simulation will end
boolean allDead = false;
boolean allInfect = true;

// ArrayList which stores all the bacteria because you can remove items
// From the list and the list changes size.
ArrayList<Bacteria> bacteria = new ArrayList<Bacteria>();

// ArrayList for food because it will be eaten and then removed from the canvas and ArrayList completely
ArrayList<Food> food = new ArrayList<Food>();


// Settings done so if I wanted to change the size then I could
void settings() {
  size(800, 800);
}

void setup() {
  // The number of bacteria is equal to an 8th of the width 
  // So that when there is a smaller width the canvas is not really crowded.
  bactNumber = round(width/8); 
  // The size of the bacteria is also proportional to the width because as the canvas decreases 
  // So will the radius
  bacteriaRadius = width/32;
  // The bacteria are drawn on the canvas in the reset function
  reset(bactNumber);
}

void draw() {
  // All infected is assumed to be true unless stated overwise
  allInfect = true;
  // Black background
  background(0);
  // Creates food and puts them into the canvas
  if(food.size() <= maxFood){
    for (int i = 0; i <= maxFood-food.size(); i++){
      food.add(new Food(random(0, width), random(0, height), random(round(width/200), round(width/175))));
    }
  }
  // Displays food
  for (int i = 0; i < food.size(); i++) {
    food.get(i).display();
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
    if (bacteria.get(i).hunger <= 0.01) {
      bacteria.remove(i);
    }
  }
}

void keyPressed() {
  // Force reset
  if (key == ' ') {
    reset(bactNumber);  
  }
}

// Reset function, will create the bacteria and add them to the list
void reset(int NUMBER_OF_BACTERIA) {
  bacteria = new ArrayList<Bacteria>();
  for (int i = 0; i < NUMBER_OF_BACTERIA; i++) {
    bacteria.add(new Bacteria(random(0, width), random(0, height), bacteriaRadius));
  }
  bacteria.get(0).infected = true;
}
