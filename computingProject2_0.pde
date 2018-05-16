// Computing project version 2.0
boolean main = true;
Main mainMen;

void setup() {
  size(600, 600);
  mainMen = new Main();
}
void draw() {
  if (main) {
    mainMen.display();
  }
}