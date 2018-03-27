// Class for the Bacterium
class Bacteria {
  float breedingChance = random(1);
  // Checking it's infected so colour can change
  boolean infected = false;
  // Diameter of bacteria
  float diameter;
  // Hunger will deplete over time
  float hunger = random(8000, 15000);
  // The metabolic rate is how much it will decrease by
  float metabolicRate = random(0.90, 0.99);
  // Velocity vector will be the speed and direction and will be add to position
  PVector vel = new PVector(BACTERIA_VEL, 0);
  // Position vector
  PVector pos;
  int rotateTimer = 1;
  int breedTimer = BREEDING_TIME; 
  // Constructor
  Bacteria(float _xPos, float _yPos, float _diameter) {
    pos = new PVector(_xPos, _yPos);
    diameter = _diameter;
    // Setting a random rotation for the Velocity
    vel.rotate(random(0, TAU));
  }
  Bacteria(Bacteria b1, Bacteria b2){
    pos = new PVector(lerp(b1.pos.x, b2.pos.x, random(1)), lerp(b1.pos.y, b2.pos.y, random(1)));
    metabolicRate = lerp(b1.metabolicRate, b2.metabolicRate, random(1));
    diameter = lerp(b1.diameter, b2.diameter, random(1));
    vel.rotate(random(0, TAU));
    infected = (b1.infected && b2.infected) || ((b1.infected || b2.infected) && random(1) < 0.5); 
  }
  // Fucntion for displaying the bacterium
  void display() {
    // If they are infected then they will be green
    // As the hunger decreases then so will the transparency 
    if (infected){
      fill(0, 255, 0, map(hunger*255, 0, 5000, 30, 255));
    } else { // If they are not infected they will be white
      fill(255, 255, 255, map(hunger*255, 0, 5000, 30, 255));
      // If they is one that is not infected, then the allInfected boolean is false
      allInfect = false;
    }
    // This is the actual bacteria
    ellipse(pos.x, pos.y, diameter, diameter);
  }
  void run() {
    if (breedTimer > 0){
      breedTimer --;
    }
    // Every certain amount of time it will choose a random direction to rotate too
    if (--rotateTimer == 0) {
      vel.rotate(random(-MAX_TURN_AMOUNT, MAX_TURN_AMOUNT));
      // Then timer is set to a random interval before it turns again
      rotateTimer = int(random(MIN_TURN_TIMER, MAX_TURN_TIMER));
    }
    // This is how the bacteria move
    pos.add(vel);
    // If the bacteria is outside the canvas then... 
    // It will constrain itself within the canvas
    // And turn itself 180 degrees
    if(pos.x >= width || pos.x <= 0){
     pos.x = constrain(pos.x, 0, width);
     vel.rotate(PI);
    }
    if(pos.y >= height || pos.y <= 0){
     pos.y = constrain(pos.y, 0, height);
     vel.rotate(PI);
    }
    // Hunger will times by metabolic rate every frame
    // This will decrease it.
    hunger *= metabolicRate;
  }
  void collide(Bacteria bact) {
    // Checking whether the bacteria collide with another
    if (dist(pos.x, pos.y, bact.pos.x, bact.pos.y) < diameter) {
      // If one of the bacteria is in infected then the other gets infected too.
      if(infected == true || bact.infected == true){
        infected = true;
        bact.infected = true;
      }
      if (random(1) <= breedingChance*bact.breedingChance && breedTimer == 0 && bact.breedTimer == 0){
        bacteria.add(new Bacteria(this, bact));
        breedTimer = BREEDING_TIME;
        bact.breedTimer = BREEDING_TIME;
      }
    }
    
  }
  void eat(Food food){
    // Checking whether colliding with food
    if (dist(pos.x, pos.y, food.xPos, food.yPos) < (diameter/2)+(food.diameter/2)){
     // When food is touched, it will replenish hunger depending on the size of the food
     hunger += (food.diameter)/32;
     food.eaten = true;
    }
  }
}