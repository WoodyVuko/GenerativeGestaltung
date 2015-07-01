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
        speed = random(5, 10);
        radius = random( 5, 10 );
        col = c;
    }
     
    void update()
    {
        object.y -= speed;
    }
     
    void render(float x, float y, float z)
    {
        stroke(col);
        fill(col);
        for (int i = 1; i < 3; i++) {
            pushMatrix();    // Breite                        Höhe                  Tiefe(tiefer, näher)
            translate (object.x + x, object.y  + y, object.z - z);
            
            sphereDetail(3);
            sphere(radius);
            // Ringe statt 3D
            //ellipse( object.x, object.y, i * radius * 2, i * radius * 2 );

            popMatrix(); 
            //println("Breite", object.x + random(1, -1500), "Höhe:", object.y  + random(0, -500), "Tiefe:", object.z - random(1200, -200));

        }
    }
     
    void reset(float scale)
    {
        object.x = random(MESH_WIDTH);
        object.y = random(height);
        object.z = random(scale);
        speed = random(5, 10);
        radius = random( 5, 10 );
    }
     
}


