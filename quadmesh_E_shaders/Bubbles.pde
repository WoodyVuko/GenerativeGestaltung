// Bubble Class       
class Bubble
{
    PVector object;
    float   speed;
    float   radius;
    color col;
     
    Bubble(float x, float y, float z, color c )
    {
        object = new PVector(x, y, z);
        radius = random( 5, 10 );
        col = c;
        speed = random(0.01, 0.1);
    }
     
    void update()
    {
        object.y -= speed;
    }
     
    void render(float x, float y, float z, float speed, int detail)
    {
        this.speed = speed;
        stroke(col);
        fill(col);
        for (int i = 1; i < 3; i++) {
            pushMatrix();    // Breite                        Höhe                  Tiefe(tiefer, näher)
            translate (object.x + x, object.y  + y, object.z - z);
            
            sphereDetail(detail);
            sphere(radius);
            // Ringe statt 3D
            //ellipse( object.x, object.y, i * radius * 2, i * radius * 2 );
            popMatrix(); 
        }
    }
     
    void reset(float scale)
    {
        object.x = random(MESH_WIDTH);
        object.y = random(height);
        object.z = random(scale);
        speed = random(00.1, 0.1);
        radius = random( 5, 10 );
    }
     
}


