public class SecondApplet extends PApplet {
  PVector pos;
  public void settings() {
    size(300, 600);
    
  }
  public void setup(){
    surface.setLocation(601, 0);
    pos = new PVector(0, 0);
  }
  public void draw() {
    background(255);
    fill(0);
    ellipse(pos.x, pos.y, 10, 10);
  }
}