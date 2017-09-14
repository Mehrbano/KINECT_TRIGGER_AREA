import SimpleOpenNI.*;

int numFrames = 12;
int offset;
int pixel;
int rawDepth;
PImage depthImg;

class KinectTracker {

  PImage flip = new PImage(kinectFrameW, kinectFrameH);

  // int threshold = ;
  int detectionZoneSize = 785; // The area beyond the threshold for detection.

  // Raw location
  PVector loc;

  // Interpolated location

  // Depth data
  int[] depth;

  SimpleOpenNI  kinect;

  PImage display;

  /******************************************************************************************/
  KinectTracker(PApplet owner) {
    kinect = new SimpleOpenNI(owner);
    // kinect.enableScene();
    kinect.enableDepth();
    kinect.setMirror(true);
    //kinect.enableIR();
    display = createImage(kinectFrameW, kinectFrameH, PConstants.RGB);
  }

  PVector getPos() {
    return loc;
  }

 PImage display() {
    PImage newImage = createImage(kinectFrameW, kinectFrameH, RGB);
    // Get the raw depth as array of integers
    try {
    depth = kinect.depthMap();
     } catch(  NullPointerException npe ) {
       println("There's a problem. kinect.depthMap() is null.");
       exit();
     }
    
    depthImg = kinect.depthImage();

    if (depth == null ) return(depthImg);

    int pix = 0;
    for (int x = 0; x < kinectFrameW; x++) {
      for (int y = 0; y < kinectFrameH; y++) {
        pixel = x+y*display.width;

        pix = x+y*kinectFrameW;
        rawDepth = depth[pix];
        if ( (rawDepth < depthThreshold) && (rawDepth > depthThreshold - detectionZoneSize ) ) {
          display.pixels[pix] = color(255, 0, 0);
        }
        else {
          display.pixels[pix] = color(0); 
        }
        flip.pixels[pix] = depthImg.pixels[y*kinectFrameW+x];
      }
    }

    display.updatePixels();
    flip.updatePixels();
    //image(display, width/2, height/2, 100, 100);
    int offset = 0;
    for (int x = -100; x < width; x += width) { 
    image (display , x, 10);
    offset+=4;
    image(display, x, height/2);
    offset+=4;
  }
    return display;
  }
 

  /*********************************************************************************************/
  PImage getDepthImage(){
    return kinect.depthImage();
  }


  /**********************************************************************************************/
  void quit() {
    // kinect.quit();
  }

  /****************************************************************************************/
  int getThreshold() {
    return depthThreshold;
  }

  /**************************************************************************************/
  void setThreshold(int t) {
    depthThreshold =  t;
  }

  /*****************************************************************************************/
  int getZone() {
    return detectionZoneSize;
  }

  /***************************************************************************************/
  void setZone(int z) {
    detectionZoneSize = z;
  }



  /*********************************************************************************************
   *
   **********************************************************************************************/
  void update(){
    kinect.update();
  }

}

