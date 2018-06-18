class Bact {
  PVector pos, size, vel;
  float rad, meta;
  boolean multiply = true; 
  float breedCoolDown = int(random(50, 500));
  int[] dna = {int(random(0, 100)), // Diameter //Numbers between 0 and a 100 represent each of the DNA values.
    int(random(0, 100)), // Mutation chance
    int(random(0, 100)), // Hue value
    int(random(0, 100)), //Increase Amount
    int(random(0, 100)), 
    int(random(0, 100)), 
    int(random(0, 100)), 
    int(random(0, 100)), 
    int(random(0, 100))}; 
  String[] dnaText = {"Diameters", "Mut Chance", "Hue Value", 
    "Incr Amount", "??????", "??????", "??????", 
    "??????", "??????", "??????", "??????"};

  int rotateTimer = int(random(MIN_TURN_TIMER, MAX_TURN_TIMER));
  Bact(PVector pos) {
    this.pos = pos;
    vel = new PVector(random(MIN_VEL, MAX_VEL), random(MIN_VEL, MAX_VEL));
    size = new PVector(map(dna[0], 0, 100, MIN_DIAMETER, MAX_DIAMETER), map(dna[0], 0, 100, MIN_DIAMETER, MAX_DIAMETER));
  }
  Bact(Bact self) {
    this.pos = self.pos.copy();
    arrayCopy(self.dna, this.dna);
    for (int i = 0; i < dna.length; i++) {
      if (random(100)<dna[1]) dna[i] = int((dna[i]+random(-5, 5)+100)%100);
    }
    this.size = self.size.copy();
    vel = new PVector(random(MIN_VEL, MAX_VEL), random(MIN_VEL, MAX_VEL));
  }
  void display() {
    stroke(0);
    fill(map(dna[2], 0, 100, 0, 255), 255, 255);
    ellipse(pos.x, pos.y, size.x, size.y);
    if (--breedCoolDown == 0) {
      multiply();
    }
    
    size.add(new PVector(map(dna[4], 0, 100, 0, 0.1), map(dna[4], 0, 100, 0, 0.1)));
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
  void create() {
    for (int i = 0; i < dna.length; i++) {
      dna[i] = int(random(0, 100));
    }
  }
  void change() {
    size = new PVector(map(dna[0], 0, 100, 2, 100), map(dna[0], 0, 100, 2, 100));
  }
  String define(int val) {
    return str(val);
  }
  void multiply() {
    if (multiply) {
      size.div(2);
      bacts.add(new Bact(this)); 
      noBacts++;
      breedCoolDown = int(random(50, 500));
      for (int i=0; i<10; i++) { 
        if (noBacts >= i*10 && noBacts <= (1+1)*10) {
          breedCoolDown += i*50;
        } 
        if (noBacts > 1000) {
          multiply = false;
        }
        if (size.x >= i*50 && size.x <= (i+1)*50) {
          breedCoolDown -= i*50;
        } else if (size.x <= i*50) {
          breedCoolDown += i*50;
        }
      }
    } else {
      if (noBacts < 1000) {
        multiply = true;
      }
    }
  }
}