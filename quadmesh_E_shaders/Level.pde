class Level
{
  float   speed;
  PApplet parent;
  Box TIT; 
  PVector size;
  Level(PApplet pa, float b, float h, float t, String vorne, String hinten, String oben, String unten, String links, String rechts) 
  {
    parent = pa;
    size = new PVector(b, h, t);
    TIT = new Box(parent, b, h, t);
    TIT = BoxTexture(TIT, vorne, hinten, links, rechts, oben, unten);
  }

  void render(float x, float y, float z)
  {
    TIT.moveTo(x, y, z);
    TIT.draw();
  }
  
  Box BoxTexture(Box lavaBox, String vorne, String hinten, String links, String rechts, String oben, String unten )
  {
    lavaBox.setTexture(hinten, lavaBox.FRONT); // Back
    lavaBox.setTexture(vorne, lavaBox.BACK);  // Front
    lavaBox.setTexture(rechts, lavaBox.LEFT);
    lavaBox.setTexture(links, lavaBox.RIGHT);
    lavaBox.setTexture(oben, lavaBox.TOP);  
    lavaBox.setTexture(unten, lavaBox.BOTTOM);
    //lavaBox.visible(true, lavaBox.BOTTOM);
    lavaBox.drawMode(Shape3D.TEXTURE);

    return lavaBox;
  }
}
