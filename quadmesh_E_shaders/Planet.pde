class Planet
{
  float   speed;
  PApplet parent;
  Ellipsoid TIT; 
  PVector size;

  Planet(int a, int b, PApplet pa, String name, int c) 
  {
    parent = pa;
    size = new PVector(a, b, c);
    TIT = AddEllipsoid(a, b, name, c);
  }

  void render(float i, float ra, float n, float x, float y, float z)
  {
    TIT.rotateBy(i, ra, n);
    TIT.moveTo(x, y, z);
    TIT.draw();
  }


  Ellipsoid AddEllipsoid (int slices, int segments, String textureFile, float radius) 
  {
    Ellipsoid aShape = new Ellipsoid(parent, slices, segments);
    aShape.setTexture(textureFile);
    aShape.drawMode(Shape3D.TEXTURE);
    aShape.setRadius(radius);
    return aShape;
  }
}

