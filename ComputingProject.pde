// Constants used for easy changing if needed to.

final float MAX_TURN_AMOUNT = HALF_PI;
final int MAX_TURN_TIMER = 60;
final int MIN_TURN_TIMER = 1;
final float BACTERIA_VEL = 2.5;

int bactNumber;
int bacteriaDiameter;

ArrayList<Bacteria> bacteria = new ArrayList<Bacteria>();

void setup() {
  size(800, 800);
  bactNumber = round(width/random(5, 15)); 
  
  bacteriaDiameter = width/32;
  reset(bactNumber);
}

void draw() {
  allInfect = true;
  background(0);
  for (int i = 0; i < bacteria.size(); i++) {
    bacteria.get(i).run();
  }
  for (int i = 0; i < bacteria.size(); i++) {
    for (int j = i+1; j < bacteria.size(); j++) {
      bacteria.get(i).collide(bacteria.get(j));
    }
  }
  for (int i = 0; i < bacteria.size(); i++) {
    bacteria.get(i).display();
  }
  if (allInfect && resetTimer == 0) {
    resetTimer = 60;
  }
  if (resetTimer != 0 && --resetTimer==0) {
    reset(bactNumber);
  }
  for(int i = bacteria.size()-1; i >= 0; i--){
    if(bacteria.get(i).hunger <= 0.01){
      bacteria.remove(i);
    } 
  }
}

void keyPressed() {
  if (key == ' ') {
    reset(bactNumber);
  }
}

boolean allInfect = true;
int resetTimer = 0;

void reset(int NUMBER_OF_BACTERIA) {
  bacteria = new ArrayList<Bacteria>();
  bactNumber = round(width/random(5, 15)); 
  for (int i = 0; i < NUMBER_OF_BACTERIA; i++) {
    bacteria.add(new Bacteria(random(0, width), random(0, height), bacteriaDiameter));
  }
  bacteria.get(0).infected = true;
}