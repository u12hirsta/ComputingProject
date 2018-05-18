class Bact {
  PVector pos, size, vel;
  float rad, meta;
  float[] dna = {rad, //Numbers between 1 and a 100 represent each of the DNA values.
               meta,
               65, 
               3, 
               2};
  int rotateTimer = int(random(MIN_TURN_TIMER, MAX_TURN_TIMER));
  Bact(PVector pos, PVector size) {
    this.pos = pos;
    this.size = size;
    vel = new PVector(random(MIN_VEL, MAX_VEL), random(MIN_VEL, MAX_VEL));
  }
  void display() {
    fill(255);
    ellipse(pos.x, pos.y, size.x, size.y);
  }
  void move() {
    if (pos.x >= width-size.x/2 || pos.x <= size.x/2) {
      pos.x = constrain(pos.x, size.x/2, width-size.x/2);
      vel.rotate(PI);
    }
    if (pos.y >= height-size.y/2 || pos.y <= size.y/2) {
      pos.y = constrain(pos.y, size.y/2, height-size.y/2);
      vel.rotate(PI);
    }
    if (--rotateTimer == 0) {
      vel.rotate(random(-MAX_TURN_AMOUNT, MAX_TURN_AMOUNT));
      // Then timer is set to a random interval before it turns again
      rotateTimer = int(random(MIN_TURN_TIMER, MAX_TURN_TIMER));
    }
    pos.add(vel);
  }
  void collide(Bact bact) {
    
  }
}