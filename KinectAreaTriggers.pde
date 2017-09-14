/* *******************************************************************

   Sketch to demonstrate using Kinect.
   The right side of the window shows the raw B&W Kinect data.
   The left side shows only what has been detected as being within a specified area
   When an object is within area, some sort of action is triggered.

   The idea for this sketch is that a user would stand some distance
   from the Kinect sensor and thrust an arm or head towards Kinect while into the bounding area, triggering design

   Target triggering is done by getting Kinect depth data, filtering for only
   those points that are within the bounding area, then rendering the results.

   The sketch depends on these Processing libraries:
 * SimpleOpenNI
 * netP5

 Copyright James Britt / Neurogami 
 james@neurogami.com

Released under the MIT License


******************************************************************* */


import java.lang.reflect.InvocationTargetException;
import java.io.IOException;
import java.lang.reflect.Method;

int depthThreshold = 790;

int[] depth;

PImage img;

KinectTracker tracker;

int shiftColorGreen = 8;

int targetThreshold = 100000;

color col = color(255, 0, 255);

int kinectFrameW = 640;
int kinectFrameH = 480;

int wd = kinectFrameW/6;
int hd = kinectFrameH/6;
int defaultTargetW = wd*2;
int defaultTargetH = hd*2;

ArrayList<Method> actionMethods;

/***********************************************************/
void setup() {
  size(1240,800);
  tracker = new KinectTracker(this);

}
/***************************************************************/
void draw() {
  background(0);
  tracker.update();
  tracker.display();

  //image(tracker.flip, kinectFrameW+1, 0);
  frame.setTitle(" " + int(frameRate ) + " ");
}
/***************************************************************/
void stop() {
 
}



