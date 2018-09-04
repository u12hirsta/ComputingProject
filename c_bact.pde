class Bact {
  PVector pos, size, vel;
  float rad, meta;
  boolean multiply = true; 
  float breedCoolDown;
  float minVel = -2.5;
  float maxVel = 2.5;
  int cellWallThickness;
  boolean frozen = false;
  boolean selected;
  int[] dna = {int(random(0, 100)), // Diameter //Numbers between 0 and a 100 represent each of the DNA values.
    int(random(0, 100)), // Mutation chance
    int(random(0, 100)), // Hue value
    int(random(0, 100)), // Breed Timer
    int(random(0, 100)), // Heat Resistance
    int(random(0, 100)), // Cell wall thickness
    int(random(0, 100)), 
    int(random(0, 100))}; 
  String[] dnaText = {"Diameter", "Mutation \nChance", "Hue Value", 
    "Breed Timer", "Heat \n reistance", "Cell wall \nthickness", 
    "??????", "??????"};
  int[] nutrientsAmount = {50, 50, 50, 50, 50, 50, 50, 50, 50};
  int rotateTimer = int(random(MIN_TURN_TIMER, MAX_TURN_TIMER));
  Bact(PVector pos) {
    this.pos = pos;
    vel = new PVector(random(minVel, maxVel), random(minVel, maxVel));
    size = new PVector(map(dna[0], 0, 100, MIN_DIAMETER, MAX_DIAMETER), map(dna[0], 0, 100, MIN_DIAMETER, MAX_DIAMETER));
    breedCoolDown = int(map(dna[3], 0, 100, 60, 300));
    cellWallThickness = int(map(dna[5], 0, 100, 1, 10));
  }
  Bact(Bact self) {
    this.pos = self.pos.copy();
    arrayCopy(self.dna, this.dna);
    for (int i = 0; i < dna.length; i++) {
      if (random(100)<dna[1]) dna[i] = int((dna[i]+random(-5, 5)+100)%100);
    }
    this.size = self.size.copy();
    vel = new PVector(random(minVel, maxVel), random(minVel, maxVel));
    breedCoolDown = int(map(dna[3], 0, 100, 60, 300));
    cellWallThickness = int(map(dna[5], 0, 100, 1, 10));
    arrayCopy(self.nutrientsAmount, this.nutrientsAmount);
  }
  void display() {
    stroke(200, 0, 0);
    strokeWeight(round(map(dna[5], 0, 100, 1, 10)));
    fill(map(dna[2], 0, 100, 0, 360), 100, 100);
    ellipse(pos.x, pos.y, size.x, size.y);
    if (selected ) {
      strokeWeight(3);
      line(pos.x-(size.x*0.5), pos.x+(size.x*0.5), pos.y-(size.y*0.5), pos.y+(size.y*0.5));
    }
  }
  void move() {
    if (!frozen) {
      if (pos.x >= (width*0.60)-size.x/2 || pos.x <= size.x/2) {
        pos.x = constrain(pos.x, size.x/2, (width*0.60)-size.x/2);
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
  }
  void create() {
    for (int i = 0; i < dna.length; i++) {
      dna[i] = int(random(0, 100));
    }
  }
  void multiply() {
    if (!frozen) {

      breedCoolDown = int(map(dna[3], 0, 100, 60, 300));
      //if (noBacts < 1000) {
      size.div(2);
      dna[0] = dna[0]/2;
      bacts.add(new Bact(this)); 
      noBacts++;
      for (int i = 0; i<sliderHolder.noSliders; i++) {
        sliderHolder.slider[i].changeSlide();
      }
    }
  }
  void change() {
    size = new PVector(map(dna[0], 0, 100, 2, 100), map(dna[0], 0, 100, 2, 100));
  }
  String define(int val) {
    return str(val);
  }
  void breedCheck() {
    if (!frozen) {
      if (--breedCoolDown <= 0) {
        multiply();
      }
    }
  }

  void sizeChange() {
    //boolean check = true;
    //if (!frozen) {
    //  for (int i = 0; i < nutrientsAmount.length; i++) {
    //    if (nutrientsAmount[i] <= 50) {
    //      check = false;
    //    }
    //  }
    //  if (check) {
    //    size.add(new PVector(map(dna[3], 0, 100, 0, 0.1), map(dna[3], 0, 100, 0, 0.1))); 
    //    dna[0] = int(size.x);
    //  }
    //}
  }
  void nutrientsCollide(Nutrients nutrients) {
    nutrientsAmount[nutrients.type] = int(nutrients.size.x);
  }
}