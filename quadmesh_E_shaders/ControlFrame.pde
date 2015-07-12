
/**
 *  The control frame class.
 */
public class ControlFrame extends PApplet {

  int w, h;
  ControlP5 cp5;
  Object parent;

  /**
   *  Constructor
   *
   * @param theParent -
   */
  public ControlFrame(Object theParent, int theWidth, int theHeight) {
    parent = theParent;
    w = theWidth;
    h = theHeight;
  }

  public void setup() {
    size(w, h);
    frameRate(25);
    cp5 = new ControlP5(this);

    cp5.addTab("Test")
      .setColorBackground(color(66, 160, 100))
        .setColorLabel(color(255))
          .setColorActive(color(255, 128, 0));

    // create tabs to arrange sliders, default is alwasy there, add another tab for sun related controls and one for terrain
    cp5.addTab("Mesh")
      .setColorBackground(color(0, 160, 100))
        .setColorLabel(color(255))
          .setColorActive(color(255, 128, 0));

    cp5.addTab("Lava")
      .setColorBackground(color(160, 0, 70))
        .setColorLabel(color(255))
          .setColorActive(color(255, 128, 0));

    cp5.addTab("Water")
      .setColorBackground(color(160, 0, 70))
        .setColorLabel(color(255))
          .setColorActive(color(255, 128, 0));

    cp5.addTab("Clouds")
      .setColorBackground(color(160, 0, 70))
        .setColorLabel(color(255))
          .setColorActive(color(255, 128, 0));

    cp5.addTab("Space")
      .setColorBackground(color(160, 0, 70))
        .setColorLabel(color(255))
          .setColorActive(color(255, 128, 0));

    cp5.addTab("Planet")
      .setColorBackground(color(160, 0, 70))
        .setColorLabel(color(255))
          .setColorActive(color(255, 128, 0));

    cp5.addTab("Land")
      .setColorBackground(color(160, 0, 70))
        .setColorLabel(color(255))
          .setColorActive(color(255, 128, 0));

    cp5.addTab("Water")
      .setColorBackground(color(0, 160, 100))
        .setColorLabel(color(255))
          .setColorActive(color(255, 128, 0));

    // create the gui elements and arrange them inside the tab
    // we need plugTo(parent), to have it accessible in the main window

    // this control effects the main app, so we move it to the default tab, which is always there
    cp5.addTextlabel("descriptionDefault")
      .plugTo(parent, "descriptionDefault")
        .setText("Steps for Z")
          .setPosition(10, 30)
            .setColorValue(0xffffffFF)
              //.setFont(createFont("Georgia",14))
              .moveTo("default");
    ;

    cp5.addSlider("Forward and Back")
      .plugTo(parent, "Forward_and_Back")
        .setRange(1, 500)
          .setValue(150)
            .setPosition(10, 50)
              .moveTo("default");

    cp5.addTextlabel("descriptionDefault2")
      .plugTo(parent, "descriptionDefault2")
        .setText("Steps for X")
          .setPosition(10, 70)
            .setColorValue(0xffffffFF)
              //.setFont(createFont("Georgia",14))
              .moveTo("default");
    ;

    cp5.addSlider("Left and Right")
      .plugTo(parent, "Left_and_Right")
        .setRange(1, 500)
          .setValue(150)
            .setPosition(10, 90)
              .moveTo("default");

    cp5.addTextlabel("descriptionDefault3")
      .plugTo(parent, "descriptionDefault3")
        .setText("Steps for Y")
          .setPosition(10, 110)
            .setColorValue(0xffffffFF)
              //.setFont(createFont("Georgia",14))
              .moveTo("default");

    cp5.addSlider("Up and Down")
      .plugTo(parent, "Up_and_Down")
        .setRange(1, 1500)
          .setValue(150)
            .setPosition(10, 130)
              .moveTo("default");      

    // Mesh

    cp5.addTextlabel("Settings: Mesh")
      .plugTo(parent, "descriptionMesh")
        .setText("Settings: Mesh")
          .setPosition(10, 30)
            .setColorValue(0xffffffFF)
              .moveTo("Mesh");

    cp5.addSlider("Size: Mesh")
      .plugTo(parent, "MESH_WIDTH")
        .setRange(1200, 3600)
          .setNumberOfTickMarks(15)
            .setValue(1200)
              .setId(8)
                .setPosition(10, 50)
                  .moveTo("Mesh"); 

    // Testing!!!!!!!!!   

    cp5.addSlider("eins")
      .plugTo(parent, "eins")
        .setRange(-600, 200)
          .setNumberOfTickMarks(100)
            .setValue(0)
              .setPosition(10, 50)
                .moveTo("Test"); 

    cp5.addSlider("zwei")
      .plugTo(parent, "zwei")
        .setRange(-700, 700)
          .setNumberOfTickMarks(100)
            .setValue(0)
              .setPosition(10, 70)
                .moveTo("Test"); 

    cp5.addSlider("drei")
      .plugTo(parent, "drei")
        .setRange(-9200, 0)
          .setNumberOfTickMarks(55)
            .setValue(0)
              .setPosition(10, 90)
                .moveTo("Test"); 

    cp5.addSlider("vier")
      .plugTo(parent, "vier")
        .setRange(-9200, 0)
          .setNumberOfTickMarks(100)
            .setValue(0)
              .setPosition(10, 110)
                .moveTo("Test"); 

    cp5.addSlider("fuenf")
      .plugTo(parent, "fuenf")
        .setRange(-9200, 0)
          .setNumberOfTickMarks(55)
            .setValue(0)
              .setPosition(10, 130)
                .moveTo("Test"); 



    // Testing!!!!!!!!!   


    cp5.addSlider("amp0")
      .plugTo(parent, "amp0")
        .setRange(100, 120)
          //.setNumberOfTickMarks(15)
          .setValue(111.11) // -1000
            .setId(10)
              .setPosition(10, 70)
                .moveTo("Land"); 

    cp5.addSlider("amp1")
      .plugTo(parent, "amp1")
        .setRange(-10000, 1000)
          //.setNumberOfTickMarks(15)
          .setValue(-1111)   //  -3200 // -1666
            .setId(10)
              .setPosition(10, 90)
                .moveTo("Land"); 

    cp5.addSlider("scale0")
      .plugTo(parent, "scale0")
        .setRange(-0.000, 0.100)
          //.setNumberOfTickMarks(15)
          .setValue(0.003)   //  0.003
              .setId(10)
              .setPosition(10, 110)
                .moveTo("Land"); 

    cp5.addSlider("scale1")
      .plugTo(parent, "scale1")
        .setRange(0.001, 0.100)
          //.setNumberOfTickMarks(15)
          .setValue(0.009)   //  0.009
              .setId(10)
              .setPosition(10, 130)
                .moveTo("Land"); 

    cp5.addSlider("y_posi")
      .plugTo(parent, "y_posi")
        .setRange(-160, -190 )
          //.setNumberOfTickMarks(15)
          .setValue(-167)   //  0.009
            .setId(11)
              .setPosition(10, 150)
                .moveTo("Land"); 
    // Lava Bubbles
    cp5.addTextlabel("Settings: Lava")
      .plugTo(parent, "descriptionLava")
        .setText("Settings: Lava")
          .setPosition(10, 30)
            .setColorValue(0xffffffFF)
              .moveTo("Lava");

    cp5.addSlider("Amount: Lava")
      .plugTo(parent, "numLava")
        .setRange(1, 150)
          .setValue(25)
            .setPosition(10, 50)
              .setNumberOfTickMarks(10)
                .setId(1)
                  .moveTo("Lava");

    cp5.addSlider("Speed: Lava")
      .plugTo(parent, "speedLava")
        .setRange(1, 35)
          .setValue(5)
            .setNumberOfTickMarks(10)
              .setPosition(10, 70)
                .moveTo("Lava");

    cp5.addSlider("Detail: Lava")
      .plugTo(parent, "detailLava")
        .setRange(1, 10)
          .setValue(3)
            .setNumberOfTickMarks(10)
              .setPosition(10, 90)
                .moveTo("Lava");

    // Fish Bubbles
    cp5.addTextlabel("Settings: Fish")
      .plugTo(parent, "descriptionFish")
        .setText("Settings: Fish")
          .setPosition(10, 30)
            .setColorValue(0xffffffFF)
              .moveTo("Water");

    cp5.addSlider("Amount: Fish")
      .plugTo(parent, "numFishes")
        .setRange(1, 250)
          .setValue(50)
            .setPosition(10, 50)
              .setNumberOfTickMarks(10)
                .setId(2)
                  .moveTo("Water");

    cp5.addSlider("Speed: Fish")
      .plugTo(parent, "speedFishes")
        .setRange(1, 35)
          .setValue(5)
            .setNumberOfTickMarks(10)
              .setPosition(10, 70)
                .moveTo("Water");

    cp5.addTextlabel("Water: Air Bubble")
      .plugTo(parent, "descriptionWaterBubbles")
        .setText("Settings: Bubbles")
          .setPosition(10, 90)
            .setColorValue(0xffffffFF)
              .moveTo("Water");

    cp5.addSlider("Amount: Air Bubble")
      .plugTo(parent, "numWater")
        .setRange(1, 150)
          .setValue(25)
            .setNumberOfTickMarks(10)
              .setPosition(10, 110)
                .setId(3)
                  .moveTo("Water");

    cp5.addSlider("Speed: Air Bubble")
      .plugTo(parent, "speedWater")
        .setRange(1, 35)
          .setValue(5)
            .setNumberOfTickMarks(10)
              .setPosition(10, 130)
                .moveTo("Water");  

    cp5.addSlider("Detail: Air Bubble")
      .plugTo(parent, "detailWater")
        .setRange(1, 10)
          .setNumberOfTickMarks(10)
            .setValue(3)
              .setPosition(10, 150)
                .moveTo("Water");  

    cp5.addTextlabel("Settings: Sharks")
      .plugTo(parent, "descriptionSharks")
        .setText("Settings: Sharks")
          .setPosition(10, 170)
            .setColorValue(0xffffffFF)
              .moveTo("Water");

    cp5.addSlider("Amount: Sharks")
      .plugTo(parent, "numSharks")
        .setRange(1, 8)
          .setValue(2)
            .setPosition(10, 190)
              .setId(9)
                .moveTo("Water");

    cp5.addSlider("Speed: Sharks")
      .plugTo(parent, "speedSharks")
        .setRange(1, 35)
          .setValue(8)
            .setNumberOfTickMarks(10)
              .setPosition(10, 210)
                .moveTo("Water");


    // Clouds
    cp5.addTextlabel("Settings: Clouds")
      .plugTo(parent, "descriptionClouds")
        .setText("Settings: Clouds")
          .setPosition(10, 30)
            .setColorValue(0xffffffFF)
              .moveTo("Clouds");

    cp5.addSlider("Amount: Clouds")
      .plugTo(parent, "numClouds")
        .setRange(0, 49)
          .setValue(10)
            .setNumberOfTickMarks(10)
              .setPosition(10, 50)
                .setId(4)
                  .moveTo("Clouds");

    cp5.addSlider("Speed: Clouds")
      .plugTo(parent, "speedClouds")
        .setRange(1, 35)
          .setValue(5)
            .setNumberOfTickMarks(10)
              .setPosition(10, 70)
                .moveTo("Clouds");

    // Space
    cp5.addTextlabel("Settings: Asteroids")
      .plugTo(parent, "descriptionAsteroids")
        .setText("Settings: Asteroids")
          .setPosition(10, 30)
            .setColorValue(0xffffffFF)
              .moveTo("Space");

    cp5.addSlider("Speed: Asteroids")
      .plugTo(parent, "speedMeteor")
        .setRange(1, 100)
          .setValue(5)
            .setPosition(10, 50)
              .setNumberOfTickMarks(10)
                .setId(6)
                  .moveTo("Space");

    cp5.addSlider("Detail: Asteroids")
      .plugTo(parent, "detailMeteor")
        .setRange(0.1, 25.00)
          .setValue(5)
            .setPosition(10, 70)
              .setNumberOfTickMarks(10)
                .setId(5)
                  .moveTo("Space");  

    cp5.addSlider("Rough: Asteroids")
      .plugTo(parent, "roughMeteor")
        .setRange(0.1, 1.8)
          .setValue(0.9)
            .setNumberOfTickMarks(10)
              .setPosition(10, 90)
                .setId(5)
                  .moveTo("Space");

    cp5.addSlider("Radius: Asteroids")
      .plugTo(parent, "radiusMeteor")
        .setRange(1, 50)
          .setValue(50)
            .setPosition(10, 110)
              .setNumberOfTickMarks(10)
                .setId(5)
                  .moveTo("Space");   

    cp5.addTextlabel("Settings: Stars")
      .plugTo(parent, "descriptionStars")
        .setText("Settings: Stars")
          .setPosition(10, 130)
            .setColorValue(0xffffffFF)
              .moveTo("Space");     

    cp5.addSlider("Amount: Stars")
      .plugTo(parent, "numStars")
        .setRange(0, 249)
          .setValue(50)
            .setPosition(10, 150)
              .setNumberOfTickMarks(10)
                .setId(7)
                  .moveTo("Space");     

    cp5.addSlider("Radius: Stars")
      .plugTo(parent, "radiusStars")
        .setRange(0, 18)
          .setValue(2)
            .setNumberOfTickMarks(10)
              .setPosition(10, 170)
                .moveTo("Space");     

    cp5.addSlider("Detail: Star")
      .plugTo(parent, "detailStars")
        .setRange(1, 10)
          .setValue(3)
            .setNumberOfTickMarks(10)
              .setPosition(10, 190)
                .moveTo("Space");  

    cp5.addSlider("Speed: Star")
      .plugTo(parent, "speedStars")
        .setRange(0.01, 10)
          .setValue(1)
            .setNumberOfTickMarks(10)
              .setPosition(10, 210)
                .moveTo("Space");

    cp5.addTextlabel("Settings: Moon")
      .plugTo(parent, "descriptionMoon")
        .setText("Settings: Moon")
          .setPosition(10, 30)
            .setColorValue(0xffffffFF)
              .moveTo("Planet");     

    cp5.addSlider("Rotation: Moon")
      .plugTo(parent, "rotationMoon")
        .setRange(0.01, 1)
          .setValue(0.25)
            .setNumberOfTickMarks(10)
              .setPosition(10, 50)
                .moveTo("Planet");   

    cp5.addTextlabel("Settings: Merkur")
      .plugTo(parent, "descriptionMerkur")
        .setText("Settings: Merkur")
          .setPosition(10, 70)
            .setColorValue(0xffffffFF)
              .moveTo("Planet");     

    cp5.addSlider("Rotation: Merkur")
      .plugTo(parent, "rotationMerkur")
        .setRange(0.01, 1)
          .setValue(0.5)
            .setNumberOfTickMarks(10)
              .setPosition(10, 90)
                .moveTo("Planet");   

    cp5.addTextlabel("Settings: Venus")
      .plugTo(parent, "descriptionVenus")
        .setText("Settings: Venus")
          .setPosition(10, 110)
            .setColorValue(0xffffffFF)
              .moveTo("Planet");     

    cp5.addSlider("Rotation: Venus")
      .plugTo(parent, "rotationVenus")
        .setRange(0.01, 1)
          .setValue(0.1)
            .setNumberOfTickMarks(10)
              .setPosition(10, 130)
                .moveTo("Planet");   

    cp5.addTextlabel("Settings: Sun")
      .plugTo(parent, "descriptionSun")
        .setText("Settings: Sun")
          .setPosition(10, 150)
            .setColorValue(0xffffffFF)
              .moveTo("Planet");     

    cp5.addSlider("Rotation: Sun")
      .plugTo(parent, "rotationSun")
        .setRange(0.01, 1)
          .setValue(0.5)
            .setNumberOfTickMarks(10)
              .setPosition(10, 170)
                .moveTo("Planet");
  }
  public void draw() {
    background(0);
    text("key commands:\nLeft: Left Arrow\nRight: Right Arrow\nInside: Up Arrow\nBack: Down Arrow\nUp: Shift\nDown: Alt\nLoad settings: L\nSave settings: S", 270, 250);
  }


  // basic load save routine, could be extended by a text field for savefile name
  void keyPressed() {
    if (key=='s') {
      cp5.saveProperties(("terrain.properties"));
    } else if (key=='l') {
      cp5.loadProperties(("terrainDefault.properties"));
    }
  }

  public ControlP5 control() {
    return cp5;
  }
}

/**
 * Function to create a control frame instance
 */
ControlFrame addControlFrame(String theName, int theWidth, int theHeight) {
  Frame f = new Frame(theName);
  ControlFrame p = new ControlFrame(this, theWidth, theHeight);
  f.add(p);
  p.init();
  f.setTitle(theName);
  f.setSize(p.w, p.h);
  f.setLocation(100, 100);
  f.setResizable(false);
  f.setVisible(true);
  return p;
}

