public class SecondApplet extends PApplet {
  Settings setting;
  public void settings() {
    size(300, 600);
    
  }
  public void setup(){
    surface.setLocation(601, 0);
    setting  = new Settings();
  }
  public void draw() {
    background(255);
    setting.changeSlider();
    setting.display();
  }
}