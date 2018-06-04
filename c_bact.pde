class Bact {
  PVector pos, size, vel;
  float rad, meta;
  int[] dna = {10, //Numbers between 0 and a 100 represent each of the DNA values.
    21, 
    65, 
    3, 
    2};          

  int rotateTimer = int(random(MIN_TURN_TIMER, MAX_TURN_TIMER));
  Bact(PVector pos) {
    this.pos = pos;
    vel = new PVector(random(MIN_VEL, MAX_VEL), random(MIN_VEL, MAX_VEL));
    size = new PVector(map(dna[0], 0, 100, 0, 100), map(dna[0], 0, 100, 0, 100));
  }
  void display() {
    fill(255);
    ellipse(pos.x, pos.y, size.x, size.y);
    text("Hi", pos.x, pos.y);
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
  void increase(int val) {
    if (dna[val] <= 100) {
      dna[val]++;
      change(val);
    }
  }
  void decrease(int val){
   if (dna[val] >= 0 ){
    dna[val]--; 
    change(val);
   }
  }
  void change(int val){
    size = new PVector(map(dna[val], 0, 100, 0, 100), map(dna[val], 0, 100, 0, 100));
  }
  String define(int val) {
    return str(val);
  }
}