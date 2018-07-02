class Nutrients {
  int type;
  PVector pos;
  Nutrients(int type, PVector pos) {
    this.pos = pos;
    this.type = type;
  }
  void display() {
    stroke(0, 0, 100);
    fill(map(type, 0, 9, 0, 360), 50, 100);
    ellipse(pos.x, pos.y, 20, 20);
  }
}