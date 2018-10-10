class Bact { // The actual Bacterium function
  float growthRate = random(0.1, 1); // Growth rate will change depending on the environment
  PVector pos, size, vel;
  float rad, meta;
  boolean multiply = true; 
  float breedCoolDown;
  float minVel = -2.5;
  float maxVel = 2.5;
  int cellWallThickness;
  boolean frozen = false;
  boolean dead = false;
  boolean selected;
  int timer = 0;
  int hunger = int(random(500, 1000));
  int[] dna = {int(random(0, 100)), // Diameter //Numbers between 0 and a 100 represent each of the DNA values.0
    int(random(0, 100)), // Mutation chance 1
    int(random(0, 100)), // Hue value 2
    int(random(0, 100)), // Breed Timer 3
    int(random(0, 100)), // Heat Resistance 4
    int(random(0, 100)), // Cell wall thickness 5 
    int(random(0, 100)), // Growth Per frame 6
    int(random(0, 100))}; // Hunger decrease per frame 7
  String[] dnaText = {"Diameter", "Mutation \nChance", "Hue Value", 
    "Breed Timer", "Heat \n reistance", "Cell wall \nthickness", 
    "Size \nincrease", "Hunger \ndecrease"}; // Text is for the sliders, so it is easy to tell which is which
  //int[] nutrientsAmount = {50, 50, 50, 50, 50, 50, 50, 50, 50};
  int rotateTimer = int(random(MIN_TURN_TIMER, MAX_TURN_TIMER)); // when this becomes 0 then the bacteria will change direction
  Bact(PVector pos) {
    this.pos = pos;
    vel = new PVector(random(minVel, maxVel), random(minVel, maxVel));
    size = new PVector(map(dna[0], 0, 100, MIN_DIAMETER, MAX_DIAMETER), map(dna[0], 0, 100, MIN_DIAMETER, MAX_DIAMETER));
    breedCoolDown = int(map(dna[3], 0, 100, 60, 300));
    cellWallThickness = int(map(dna[5], 0, 100, 1, 10));
  }
  Bact(Bact self) { // Second constructor for when the bacteria breeds, so that they can have the same dna (and a mutation)
    this.pos = self.pos.copy();
    arrayCopy(self.dna, this.dna);
    for (int i = 0; i < dna.length; i++) {
      if (random(100)<dna[1]) dna[i] = int((dna[i]+int(random(-1, 1))+100)%100);
    }
    this.size = self.size.copy();
    vel = new PVector(random(minVel, maxVel), random(minVel, maxVel));
    breedCoolDown = int(map(dna[3], 0, 100, 60, 300));
    cellWallThickness = int(map(dna[5], 0, 100, 1, 10));
    //arrayCopy(self.nutrientsAmount, this.nutrientsAmount);
  }
  void display() {

    if (selected ) {
      noFill();
      strokeWeight(3);
      stroke(0, 0, 100);
      rect(pos.x, pos.y, size.x*1.5, size.y*1.5); //  Adds a rectangle around the bacteria, so that you know it is the one which is selected
    }
    stroke(200, 0, 0);
    strokeWeight(round(map(dna[5], 0, 100, 1, 10)));
    fill(map(dna[2], 0, 100, 0, 360), 100, 100);
    ellipse(pos.x, pos.y, size.x, size.y);
  }
  void move() {
    if (!frozen) { // Will not move if frozen
      hunger=hunger-(dna[7]/10);
      if (pos.x >= (width*0.60)-size.x/2 || pos.x <= size.x/2) {
        pos.x = constrain(pos.x, size.x/2, (width*0.60)-size.x/2);
        vel.rotate(PI); // If it is touching the edge it will turn around 180 degrees
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
      pos.add(vel); // Vectors are added to together to make the bacteria move
      if(hunger <= 0){
       dead = true; 
      }
    }
    for(int i = 0; i<dna.length; i++){ // the dna values should always be between 0 and 100
     dna[i] = constrain(dna[i],  0, 100);
    }
  }
  void create() { 
    for (int i = 0; i < dna.length; i++) { // Creates new dna, when this is called
      dna[i] = int(random(0, 100));
    }
  }
  void multiply() {
    temperature(); // changes certain characteristics when it's too hot/cold
    hyperthermia(); // Kills them when it's too hot
    if (!frozen) { // They can't breed when they are frozen

      breedCoolDown = int(map(dna[3], 0, 100, 60, 300));
      //if (bacts.size() < 1000) {
      size.div(2);
      dna[0] = dna[0]/2;
      bacts.add(new Bact(this)); 
      for (int i = 0; i<sliderHolder.noSliders; i++) {
        sliderHolder.slider[i].changeSlide();
      }
    }
  }
  void change() {
    size = new PVector(map(dna[0], 0, 100, 2,75), map(dna[0], 0, 100, 2, 75)); // When the size is changed anywhere in the dna, it is called here
  }
  String define(int val) { // Turns value to a string
    return str(val);
  }
  void breedCheck() { // when their breed timer is 0 they will multiply
    if (!frozen) {
      if (--breedCoolDown <= 0) {
        multiply();
      }
    }
  }

  void sizeChange() {
    if (!frozen) {
      if (size.x <= map(dna[6], 0, 100, 2, 75)){ // They will grow over time, depending on the enviroment
        dna[0]+=growthRate;
        change();
      }
    }
  }
  void temperature(){ 
    growthRate = (((growthRate*map(simulation.temperature, -50, 100, 0.1, 2))/map(bacts.size(), 1, 500, 0.1, 5)));//*map(hunger, 0, 1000, 0, 2)); //If the temp is higher the growth rate increases and if there are too many bacts it decreases
    vel.mult(map(simulation.temperature, -50, 100, 0.1, 2)*(hunger<500?map(hunger, 0, 500, 0, 1):map(hunger, 500, 1000, 1, 0))*map(size.x, 0, 100, 1, 0.01)); // Vel is increased or slowed depending on temp
    breedCoolDown=breedCoolDown/map(simulation.temperature, -50, 100, 0.1, 2); // breeding is increased of slowed depending on temp
  }
  void hyperthermia(){ // hyperthermia is death by heat
    if(simulation.temperature >= 60*map(dna[4], 0, 100, 0, 1.5)){
      dead = true;
    }
    
  }
  boolean clicked() {
    if(mouseX >= pos.x-size.x/2 && mouseX <= pos.x+size.x/2 && mouseY >= pos.y-size.y/2 && mouseY <= pos.y+size.y/2){
     return true; 
    }
    else {
     return false; 
    }
  }
  void foodCollide(Food food) {
     hunger+=food.size.x;
  }
}
