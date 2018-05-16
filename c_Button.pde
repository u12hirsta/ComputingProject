  class Button {
    PVector pos, size;
    Button(PVector pos, PVector size){
      this.pos = pos;
      this.size = size;
    }
    void display() {
      fill(255);
      rect(pos.x, pos.y, size.x, size.y, size.y*0.5);
    }
    Boolean hover(){
      
    }
  }