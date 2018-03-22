// Class for food

class Food {
  // Food will be randomly placed around the area
  // Radius will be different and the different sizes will replenish different amounts of hunger
  float xPos, yPos, radius;
  Food(float _xPos, float _yPos, float _radius) {
    xPos = _xPos;
    yPos = _yPos;
    radius = _radius;
  }
  void display(){
    // Food will be circles and will be blue
    // So easily distinguishable from the bacteria
    fill(0, 0, 255);
    ellipse(xPos, yPos, radius, radius);
  }
}
