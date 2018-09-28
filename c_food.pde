class Food {
  PVector pos, size;
  Food(PVector pos, PVector size) {
    this.pos = pos;
    this.size = size;
  }
  void display() {
    stroke(0, 20, 60);
    fill(0, 0, 100);
    ellipse(pos.x, pos.y, size.x, size.y);
  }
}
