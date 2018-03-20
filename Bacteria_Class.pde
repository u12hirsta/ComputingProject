 // Class for the Bacterium

class Bactium {
  boolean infected = false;
  float diameter;
  float hunger = random(8000, 15000);
  float hungerDecayRate = random(0.95, 0.99);
  PVector vel = new PVector(Bactium_VEL, 0);
  PVector pos;
  int timer = 1;
  Bactium(float _xPos, float _yPos, float _diameter) {
    pos = new PVector(_xPos, _yPos);
    diameter = _diameter;
    vel.rotate(random(0, TAU));
  }
  void display() {
    if (infected){
      fill(0,255,0);
      fill(0, 255, 0, (hunger)*255);
    } else {
      fill(255, 255, 255, (hunger)*255);
      allInfect = false;
    }
    ellipse(pos.x, pos.y, diameter, diameter);
  }
  void run() {
    if (--timer == 0) {
      vel.rotate(random(-MAX_TURN_AMOUNT, MAX_TURN_AMOUNT));
      timer = int(random(MIN_TURN_TIMER, MAX_TURN_TIMER));
    }
    pos.add(vel);
    if(pos.x >= width || pos.x <= 0){
     vel.rotate(PI);
    }
    if(pos.y >= height || pos.y <= 0){
     vel.rotate(PI);
    }
    hunger *= hungerDecayRate;
  }
  void collide(Bactium bact) {
    if (dist(pos.x, pos.y, bact.pos.x, bact.pos.y) < diameter) {
      vel.rotate(PI);
      bact.vel.rotate(PI);
      if(infected == true || bact.infected == true){
        infected = true;
        bact.infected = true;
      }
    }
  }
}