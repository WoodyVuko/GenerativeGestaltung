
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
    
    
    // create tabs to arrange sliders, default is alwasy there, add another tab for sun related controls and one for terrain
    cp5.addTab("Lava")
     .setColorBackground(color(0, 160, 100))
     .setColorLabel(color(255))
     .setColorActive(color(255,128,0));

    cp5.addTab("Water")
     .setColorBackground(color(160, 0, 70))
     .setColorLabel(color(255))
     .setColorActive(color(255,128,0));
    
    cp5.addTab("Clouds")
     .setColorBackground(color(160, 0, 70))
     .setColorLabel(color(255))
     .setColorActive(color(255,128,0));
    
    cp5.addTab("Asteroids")
     .setColorBackground(color(160, 0, 70))
     .setColorLabel(color(255))
     .setColorActive(color(255,128,0));
        
     
     
    // create the gui elements and arrange them inside the tab
    // we need plugTo(parent), to have it accessible in the main window
     
     // this control effects the main app, so we move it to the default tab, which is always there
      cp5.addTextlabel("descriptionDefault")
      .plugTo(parent, "descriptionDefault")
      .setText("Steps for Z")
      .setPosition(10,30)
      .setColorValue(0xffffffFF)
      //.setFont(createFont("Georgia",14))
      .moveTo("default");;
      
      cp5.addSlider("Forward and Back")
      .plugTo(parent, "Forward_and_Back")
      .setRange(1, 500)
      .setValue(150)
      .setPosition(10,50)
      .moveTo("default");
      
      cp5.addTextlabel("descriptionDefault2")
      .plugTo(parent, "descriptionDefault2")
      .setText("Steps for X")
      .setPosition(10,70)
      .setColorValue(0xffffffFF)
      //.setFont(createFont("Georgia",14))
      .moveTo("default");;
      
      cp5.addSlider("Left and Right")
      .plugTo(parent, "Left_and_Right")
      .setRange(1, 500)
      .setValue(150)
      .setPosition(10,90)
      .moveTo("default");
      
      cp5.addTextlabel("descriptionDefault3")
      .plugTo(parent, "descriptionDefault3")
      .setText("Steps for Y")
      .setPosition(10,110)
      .setColorValue(0xffffffFF)
      //.setFont(createFont("Georgia",14))
      .moveTo("default");
      
      cp5.addSlider("Up and Down")
      .plugTo(parent, "Up_and_Down")
      .setRange(1, 1500)
      .setValue(150)
      .setPosition(10,130)
      .moveTo("default");      
// Lava Bubbles
       cp5.addTextlabel("Settings: Lava")
      .plugTo(parent, "descriptionLava")
      .setText("Settings: Lava")
      .setPosition(10,30)
      .setColorValue(0xffffffFF)
      .moveTo("Lava");
      
      cp5.addSlider("Amount: Lava")
      .plugTo(parent, "numLava")
      .setRange(1, 150)
      .setValue(50)
      .setPosition(10,50)
      .setId(1)
      .moveTo("Lava");

      cp5.addSlider("Speed: Lava")
      .plugTo(parent, "speedLava")
      .setRange(1, 35)
      .setValue(5)
      .setPosition(10,70)
      .moveTo("Lava");
      
      cp5.addSlider("Detail: Lava")
      .plugTo(parent, "detailLava")
      .setRange(1, 10)
      .setValue(3)
      .setPosition(10,90)
      .moveTo("Lava");
        
// Fish Bubbles
       cp5.addTextlabel("Settings: Fish")
      .plugTo(parent, "descriptionFish")
      .setText("Settings: Fish")
      .setPosition(10,30)
      .setColorValue(0xffffffFF)
      .moveTo("Water");
      
      cp5.addSlider("Amount: Fish")
      .plugTo(parent, "numFishes")
      .setRange(1, 250)
      .setValue(50)
      .setPosition(10,50)
      .setId(2)
      .moveTo("Water");
      
      cp5.addSlider("Speed: Fish")
      .plugTo(parent, "speedFishes")
      .setRange(1, 35)
      .setValue(5)
      .setPosition(10,70)
      .moveTo("Water");
      
      cp5.addTextlabel("Water: Air Bubble")
      .plugTo(parent, "descriptionWaterBubbles")
      .setText("Settings: Bubbles")
      .setPosition(10,90)
      .setColorValue(0xffffffFF)
      .moveTo("Water");
      
      cp5.addSlider("Amount: Air Bubble")
      .plugTo(parent, "numWater")
      .setRange(1, 150)
      .setValue(50)
      .setPosition(10,110)
      .setId(3)
      .moveTo("Water");
      
      cp5.addSlider("Speed: Air Bubble")
      .plugTo(parent, "speedWater")
      .setRange(1, 35)
      .setValue(5)
      .setPosition(10,130)
      .moveTo("Water");  
        
      cp5.addSlider("Detail: Air Bubble")
      .plugTo(parent, "detailWater")
      .setRange(1, 10)
      .setValue(3)
      .setPosition(10,150)
      .moveTo("Water");  

// Clouds
      cp5.addTextlabel("Settings: Clouds")
      .plugTo(parent, "descriptionClouds")
      .setText("Settings: Clouds")
      .setPosition(10,30)
      .setColorValue(0xffffffFF)
      .moveTo("Clouds");
      
      cp5.addSlider("Amount: Clouds")
      .plugTo(parent, "numClouds")
      .setRange(0, 49)
      .setValue(10)
      .setPosition(10,50)
      .setId(4)
      .moveTo("Clouds");

      cp5.addSlider("Speed: Clouds")
      .plugTo(parent, "speedClouds")
      .setRange(1, 35)
      .setValue(5)
      .setPosition(10,70)
      .moveTo("Clouds");

// Space
       cp5.addTextlabel("Settings: Asteroids")
      .plugTo(parent, "descriptionAsteroids")
      .setText("Settings: Asteroids")
      .setPosition(10,30)
      .setColorValue(0xffffffFF)
      .moveTo("Space");
      
      cp5.addSlider("Amount: Asteroids")
      .plugTo(parent, "numMeteor")
      .setRange(1, 150)
      .setValue(20)
      .setPosition(10, 50)
      .setId(5)
      .moveTo("Space");
      
      cp5.addSlider("Speed: Asteroids")
      .plugTo(parent, "speedMeteor")
      .setRange(1, 100)
      .setValue(5)
      .setPosition(10,70)
      .setId(6)
      .moveTo("Space");
      
      cp5.addSlider("Zoom: Asteroids")
      .plugTo(parent, "zoomMeteor")
      .setRange(0.1, 1.00)
      .setValue(50)
      .setPosition(10, 90)
      .setId(6)
      .moveTo("Space");
      
      cp5.addSlider("Detail: Asteroids")
      .plugTo(parent, "detailMeteor")
      .setRange(0.1,25.00)
      .setValue(5)
      .setPosition(10, 110)
      .setId(6)
      .moveTo("Space");  
        
      cp5.addSlider("Rough: Asteroids")
      .plugTo(parent, "roughMeteor")
      .setRange(0.1, 1.8)
      .setValue(0.9)
      .setPosition(10,130)
      .setId(6)
      .moveTo("Space");
      
      cp5.addSlider("Radius: Asteroids")
      .plugTo(parent, "radiusMeteor")
      .setRange(1, 100)
      .setValue(50)
      .setPosition(10,150)
      .setId(6)
      .moveTo("Space");   
      
       
}
  public void draw() {
    background(0);
    text("key commands:\n(l)oad settings\n(s)ave settings",0,200);
  }
  
  
  // basic load save routine, could be extended by a text field for savefile name
  void keyPressed() {
  if (key=='s') {
    cp5.saveProperties(("terrain.properties"));
  } 
  else if (key=='l') {
    cp5.loadProperties(("terrain.properties"));
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

