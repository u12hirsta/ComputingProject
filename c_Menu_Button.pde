// Class for the buttons in the menu

class Button {
  float posX, posY, size;
  int type;   // Increase/decrease
  int change; // Numbers correspond to which part it is changing
  color myFill;
  Button(float _posX, float _posY, float _size, int _type, int _change, color col){
   posX = _posX;
   posY = _posY;
   size = _size;
   type = _type;
   myFill = col;
   change = _change;
  }
  void display(){
    fill(myFill);
    rect(posX, posY, size, size, size/8);
  }
}