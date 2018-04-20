// Class for the Bacterium
class Bacteria {
  int dna[] = new int[4];
  float breedingChance = random(1);
  //Checking it's infected so colour can change
  boolean infected = false;
  // Boolean for whether menu is open
  boolean menu = false;
  // Diameter of bacteria
  float diameter;
  // Hunger will deplete over time
  float hunger = random(MIN_HUNGER, MAX_HUNGER);
  // The metabolic rate is how much it will decrease by
  float metabolicRate;
  // Velocity vector will be the speed and direction and will be add to position
  PVector vel;
  // Position vector
  PVector pos;
  int rotateTimer = 1;
  int breedTimerOriginal = int(random(30, 100));
  int breedTimer = 50;
  float severity;
  int noButtons = 8;
  float menuWidth = 0.4;
  float menuHeight = 0.5;
  // Constructor
  Bacteria(float _xPos, float _yPos) {
    pos = new PVector(_xPos, _yPos);
    for (int i = 0; i < dna.length; i++) {
      dna[i] = int(random(100));
    }
    create();
    // Setting a random rotation for the Velocity
    vel.rotate(random(0, TAU));
  }
  Bacteria(Bacteria b1, Bacteria b2) {
    pos = new PVector(lerp(b1.pos.x, b2.pos.x, random(1)), lerp(b1.pos.y, b2.pos.y, random(1)));
    for (int i = 0; i < dna.length; i++) {
      dna[i] = constrain((random(1)<0.5?b1.dna[i]:b2.dna[i])+random(1)<0.1?int(random(-2, 2)):0, 0, 100);
    }
    infected = (b1.infected && b2.infected) || ((b1.infected || b2.infected) && random(1) < 0.5);
    create();
  }
  float getCode(int n, float min, float max) {
    float returnValue = map(dna[n], 0, 100, min, max);
    return returnValue;
  }
  void create() {
    diameter = getCode(0, MIN_DIAMETER, MAX_DIAMETER);
    metabolicRate = getCode(1, MIN_META, MAX_META);
    vel = new PVector(getCode(2, MIN_BACTERIA_VEL, MAX_BACTERIA_VEL), 0);
    vel.rotate(random(0, TAU));
  }
  // Function for displaying the bacterium
  void display() {
    if (menu) {
      menu();
    }
    // If they are infected then they will be green
    // As the hunger decreases then so will the transparency
    if (severity != 0) {
      fill(0, map(severity*255, 0, 255, 50, 255), 0, map(hunger, 0, 5000, 30, 255));
      // If they are not infected they will be white
    } else {
      fill(255, 255, 255, map(hunger, 0, 5000, 30, 255));
    }
    if (infected == false) { // If they is one that is not infected, then the allInfected boolean is false
      allInfect = false;
    }
    // This is the actual bacteria
    ellipse(pos.x, pos.y, diameter, diameter);
  }
  void run() {
    if (move == true) {
      if (breedTimer > 0) {
        breedTimer --;
      }
      if (severity >= 0.5) {
        infected = true;
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
      if (pos.x >= width || pos.x <= 0) {
        pos.x = constrain(pos.x, 0, width);
        vel.rotate(PI);
      }
      if (pos.y >= height || pos.y <= 0) {
        pos.y = constrain(pos.y, 0, height);
        vel.rotate(PI);
      }
      // Hunger will times by metabolic rate every frame
      // This will decrease it.
      /* Tried the method
       hunger = pow(hunger, metabolicRate);
       Did not work to how I wanted it too
       Instead having it linear like this...*/
      if (infected) {
        hunger -= 30*severity*metabolicRate;
      } else { // Infected will die of hunger faster because they are fighting off the disease
        hunger -= 20*metabolicRate;
      }
    }
  }
  void collide(Bacteria bact) {
    if (move == true) {
      // Checking whether the bacteria collide with another
      if (dist(pos.x, pos.y, bact.pos.x, bact.pos.y) < diameter/2+bact.diameter/2 && random(1) < severity) {
        // If the severity of one bacteria is higher than the other then it will infect the other
        // If the severity is the same nothing will happen
        if (severity < bact.severity) {
          severity = bact.severity;
        } else if (severity > bact.severity) {
          bact.severity = severity;
        }
        //float thisTemp = constrain(severity + bact.severity/2, 0, 1);
        //float bactTemp = constrain(severity/2 + bact.severity, 0, 1);
        //severity = thisTemp;
        //bact.severity = bactTemp;
        if (random(1) <= (breedingChance+bact.breedingChance)/2 && breedTimer == 0 && bact.breedTimer == 0) {
          bacteria.add(new Bacteria(this, bact));
          breedTimer = breedTimerOriginal;
          bact.breedTimer = breedTimerOriginal;
        }
      }
    }
  }
  void eat(Food food) {
    // Checking whether colliding with food
    if (dist(pos.x, pos.y, food.xPos, food.yPos) < (diameter/2)+(food.diameter/2)) {
      // When food is touched, it will replenish hunger depending on the size of the food
      hunger += (food.diameter)/32;
      severity += food.infectSeverity;
      food.eaten = true;
    }
  }
  void clicked() {
    if (dist(pos.x, pos.y, mouseX, mouseY) < diameter/2 && mousePressed && pos.x <= width-(width*menuWidth) && pos.y <= height-(height*menuHeight) && menuOpen == false) {
      menu = true;
      move = false;
      menuOpen = true;
    }
  }
  void data() {
    fill(255);
    text(breedingChance +"\n" + severity + "\n" + hunger + "\n", pos.x+diameter/2, pos.y);
  }
  void menu() {
    fill(255);
    rect(pos.x, pos.y, width*menuWidth, height*menuHeight, 20);
    fill(200, 0, 0);
    ellipse(pos.x+width*menuWidth, pos.y, 25, 25);
    textAlign(TOP, LEFT);
    fill(0);
    textSize(height*0.02);
    String hung = nf(hunger, 0, 2);
    String breeding = nf(breedingChance, 0, 2);
    String meta = nf(metabolicRate, 0, 2);
    String sev = nf(severity, 0, 2);
    text("Hunger        : " + hung +
       "\nMetaRate      : "+meta +
       "\nBreedChance   : "+breeding+
       "\nSeverity      : "+sev
      , pos.x+10, pos.y+10);
    for(int i = 0; i < 4; i++){
      button[i] = new Button((pos.x+width*menuWidth)-height*(i<4?0.1:0.075), pos.y+height*(0.001+(i*0.025)), height*0.025, (i<4?0:1), i, color((i<4?255:0), (i>=4?255:0), 0));
      button[i].display();
    }
 
    /*// Hunger buttons
    button[0] = new Button((pos.x+width*menuWidth)-height*0.1, pos.y+height*0.001, height*0.025, 0, 0, color(255, 0, 0));
    button[0].display();
    button[0] = new Button((pos.x+width*menuWidth)-height*0.075, pos.y+height*0.001, height*0.025, 1, 0, color(0, 255, 0));
    button[0].display();
    // Metabolic rate buttons
    button[0] = new Button((pos.x+width*menuWidth)-height*0.1, pos.y+height*0.026, height*0.025, 0, 1, color(255, 0, 0));
    button[0].display();
    button[0] = new Button((pos.x+width*menuWidth)-height*0.075, pos.y+height*0.026, height*0.025, 1, 1, color(0, 255, 0));
    button[0].display();
    // Breeding Chance buttons
    button[0] = new Button((pos.x+width*menuWidth)-height*0.1, pos.y+height*0.051, height*0.025, 0, 2, color(255, 0, 0));
    button[0].display();
    button[0] = new Button((pos.x+width*menuWidth)-height*0.075, pos.y+height*0.051, height*0.025, 1, 2, color(0, 255, 0));
    button[0].display();
    // Severity
    button[0] = new Button((pos.x+width*menuWidth)-height*0.1, pos.y+height*0.026, height*0.025, 0, 3, color(255, 0, 0));
    button[0].display();
    button[0] = new Button((pos.x+width*menuWidth)-height*0.075, pos.y+height*0.026, height*0.025, 1, 3, color(0, 255, 0));
    button[0].display();*/
    if (mousePressed && mouseX <= pos.x+(width*menuWidth)+12.5 && mouseX >= pos.x+(width*menuWidth)-12.5 && mouseY <= pos.y+12.5 && mouseY >= pos.y-12.5) {
      move = true;
      menu = false;
      menuOpen = false;
    }
  }
}