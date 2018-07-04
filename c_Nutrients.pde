class Nutrients {
  int type;
  PVector pos, size;
  Nutrients(int type, PVector pos, float x) {
    size = new PVector(0, 0);
    this.pos = pos;
    this.type = type;
    size.x = x;
    size.y = size.x;
  }
  void display() {
    stroke(0, 0, 100);
    fill(map(type, 0, 9, 0, 360), 50, 100);
    ellipse(pos.x, pos.y, size.x, size.y);
  }
}