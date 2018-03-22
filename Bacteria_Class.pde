// Class for the Bacterium
class Bacteria {
  // Checking it's infected so colour can change
  boolean infected = false;
  // Diameter of bacteria
  float diameter;
  // Hunger will deplete over time
  float hunger = random(8000, 15000);
  // The metabolic rate is how much it will decrease by
  float metabolicRate = random(0.95, 0.99);
  // Velocity vector will be the speed and direction and will be add to position
  PVector vel = new PVector(BACTERIA_VEL, 0);
  // Position vector
  PVector pos;
  int timer = 1;
  // Constructor
  Bacteria(float _xPos, float _yPos, float _diameter) {
    pos = new PVector(_xPos, _yPos);
    diameter = _diameter;
    // Setting a random rotation for the Velocity
    vel.rotate(random(0, TAU));
  }
  // Fucntion for displaying the bacterium
  void display() {
    // If they are infected then they will be green
    // As the hunger decreases then so will the transparency 
    if (infected){
      fill(0, 255, 0, constrain(hunger*255, 60, 255));
    } else { // If they are not infected they will be white
      fill(255, 255, 255, constrain((hunger)*255, 60, 255));
      // If they is one that is not infected, then the allInfected boolean is false
      allInfect = false;
    }
    // This is the actual bacteria
    ellipse(pos.x, pos.y, diameter, diameter);
  }
  void run() {
    // Every certain amount of time it will choose a random direction to rotate too
    if (--timer == 0) {
      vel.rotate(random(-MAX_TURN_AMOUNT, MAX_TURN_AMOUNT));
      // Then timer is set to a random interval before it turns again
      timer = int(random(MIN_TURN_TIMER, MAX_TURN_TIMER));
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
      // If the bacteria collide with eachother then they rotate 180 degrees or pi radians  
      vel.rotate(PI);
      // The other bacteria rotates by 180 degrees
      bact.vel.rotate(PI);
      // They then move by 2 velocity to move out of the way of the bacterias
      pos.add(vel).add(vel);
      // If one of the bacteria is in infected then the other gets infected too.
      if(infected == true || bact.infected == true){
        infected = true;
        bact.infected = true;
      }
    }
  }
  void eat(Food food){
    
  }
}
