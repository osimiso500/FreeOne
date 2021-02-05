// IMPORT THE SPOUT LIBRARY
import spout.*;
//import processing.video.*;
import com.hamoid.*;

// Images anlegen um Pixel zu speichern
PImage img, imgEx;

float time;
float tresholdDef = 1.0;
float sabaDef = 0.0;
float sobelDef = 1.0;
float sprungDef = 0.0;
float posterDef=2.0;
float colorFreQ=6.0;

float wbControl = 3;
//Diese Variable wird genutzt um zu entscheiden ob die schwarzen oder die weißen Bereiche eingefärbt werden default = 1
int displaySettings = 2;
//ermöglicht die Aktivierung verschiedener AusgabeOptionen default = 2
int whichFilter = 5;
//welcher Filter wird angewendet? deafult = 5
int zeilensprung=0;
int sketchFPS = 30;

int freq=0;

float a=125,b=125,c=125;
float colorWert1 = 75;

String infoFilter="NOFILTER is on";
String infowbControl = "WBControl Mode 3 is on";
String infoDisplay="Image is on";

//Arrays zum speichern der Controller-Parameter anlegen
String[] controlName;
int[] controlType;
float[] controlValue;
String[] controlText;

String setFPS = "default";// Text
String[] setFPSdyn;
String[] setFPSdynEX;
String checkFPS = "eins"; 

boolean videoActive;
PrintWriter output;

int fCount = 0;
int tempfCount = 0;


//Spout Objekte deklarieren
Spout spout, spoutSend, spoutSend2, spoutController;
//Spout Objekte deklarieren
VideoExport videoExport;

void setup() {

  // Anfangsgrösse des Fensters
  size(1280, 720, P3D);

  //Images erzeugen um Daten zu speichern
  img = createImage(width, height, RGB);
  imgEx = createImage(width, height, RGB);

  //Arrays zum speichern der Controller-Parameter erstellen
  controlName = new String[20];
  controlType = new int[20];
  controlValue = new float[20];
  controlText = new String[20];

  setFPSdyn = new String[] {"eins"};
  setFPSdynEX = new String[1];

  spout = new Spout(this); //SPout Objekt wird instanziiert
  spoutSend = new Spout(this); //SPoutSend Objekt wird instanziiert
  spoutSend2 = new Spout(this); //SPoutSend Objekt wird instanziiert
  spoutController = new Spout(this); //SPoutController Objekt wird instanziiert

  spoutController.createSpoutControl("NOR<IN>OFF", "float", 1.3, 3.7, 3.7); 
  spoutController.createSpoutControl("Tresh", "event",0);
  spoutController.createSpoutControl("TreshDef", "float", 0.0, 1.0, 0.0); 
  spoutController.createSpoutControl("OWN+COLORPIXEL", "event",0); 
  spoutController.createSpoutControl("COLPIX_FREQ", "float", 1.0,30.0, 6.0); 
  spoutController.createSpoutControl("OWN", "event",0); 
  spoutController.createSpoutControl("OWN_Def", "float", 0, 34, 0);
  spoutController.createSpoutControl("COLORPIXEL", "event",0);  
  spoutController.createSpoutControl("Set_FPS", "text",0); 
  spoutController.createSpoutControl("StartVideoEx", "event",0); 
  spoutController.createSpoutControl("EndVideoEx", "event",0); 

  spoutController.openSpoutControls("FreeOne");

  String filename = "fps.txt";
  File f = new File(sketchPath(filename));

  boolean exists = f.exists();
  if (exists) {;
  } 
  else {
    saveStrings("fps.txt", setFPSdyn);
  } 
  
  setFPSdynEX = loadStrings("fps.txt");
  checkFPS = setFPSdynEX[0];


  if (checkFPS.equals("eins")) {
    sketchFPS = 25;
  } 
  else if (checkFPS.equals("zwei")) {
    sketchFPS = 30;
  } 
  else if (checkFPS.equals("drei")) {
    sketchFPS = 50;
  } 
  else if (checkFPS.equals("vier")) {
    sketchFPS = 60;
  } 
  else if (checkFPS.equals("fünf")) {
    sketchFPS = 20;
  } 
  else {
    sketchFPS = 25;
  }

  //Framerate der Anwendung festlegen
  frameRate(sketchFPS+1);
} 

void draw() {

  background(0); 

  int nControls = spoutController.checkSpoutControls(controlName, controlType, controlValue, controlText); 
  

  for (int i = 0; i < nControls; i++) {
    // "Welcher Filter wird gewählt"
    if (controlName[i].equals("NOR<IN>OFF")) {
      if(controlValue[i] < 2){
        infowbControl = "WBControl Mode 1 is on";
      }
      else if(controlValue[i] >= 2 && controlValue[i] < 3){
        infowbControl = "WBControl Mode 2 is on";
      }
      else if(controlValue[i] > 3){
        infowbControl = "WBControl is off";
      }
      wbControl = controlValue[i];
    }
    if (controlName[i].equals("Tresh")&&controlValue[i]==1) {
      infoFilter="THRESHOLD is on";
      whichFilter = 1;
    }
    if (controlName[i].equals("OWN+COLORPIXEL")&&controlValue[i]==1) {   
      infoFilter="LINE+COLORPIXEL is on";
      freq=0;
      whichFilter = 2;
    }
    if (controlName[i].equals("COLORPIXEL")&&controlValue[i]==1) {
      infoFilter="COLORPIXEL is on";
      freq=0;
      whichFilter = 3;
    }
    if (controlName[i].equals("OWN")&&controlValue[i]==1) { 
      infoFilter="OWN is on";
      whichFilter = 4;
    }
    if (controlName[i].equals("TreshDef")) {
      tresholdDef = controlValue[i];
    }
    if (controlName[i].equals("COLPIX_FREQ")) {
      colorFreQ = controlValue[i];
    }
    if (controlName[i].equals("OWN_Def")) {
      sprungDef = controlValue[i];
    }
    if (controlName[i].equals("StartVideoEx")&&controlValue[i]==1) {
      videosettings();
      displaySettings = 3;
      //start the Video Export
      videoExport.startMovie();
    }
    if (controlName[i].equals("EndVideoEx")&&controlValue[i]==1) {
      displaySettings = 2;
      whichFilter = 5;
      exitVideoOrNot();
    }
    if (controlName[i].equals("Set_FPS")) {
      try
      {
      setFPS = controlText[i];
      setFramerate();
      }
      catch(Exception e){
          setFPS = checkFPS;
          setFramerate();
      }
    }
  }


  img = spout.receivePixels(img); 
  //Es wird ein Receiver erzeugt
  //Die von SPout empfangenen Pixel werden in ein PImage Objekt gespeichert
  imgEx = spout.receivePixels(imgEx); 
  //Die Daten werden ein zweites Mal empfangen 

  img.loadPixels(); //Pixel werden in den PixelArray geladen
  imgEx.loadPixels(); //Pixel werden in den PixelArray geladen

  selectFilter(); 
  //In dieser Funktion werden die Algorithmen in einem switch-case ausgewählt.
  //Die Variable whichFilter speichert den Parameter für den switch-case
  
  img.updatePixels();//Pixel im PixelArray werden geupdated
  
  wbControl(); 
  //Diese Funktion legt fest in welche Pixel geschwärzt werden oder nicht. 
  //Dazu ist ein switch-case angelegt worden
  //oder es wird keine Operation vorgenommen im case 3
  //Dies wird anhand des Parameters wbControl entschieden.

  imgEx.updatePixels(); 
  //Nach der Verarbeitung durch einen Filter werden hier die Pixel in ImgEx aktualisiert.

  setDisplayOptions();  
  //In dieser Funktion wird anhand einer Variable entschieden, 
  //wie die Ausgabe auszuführen ist. Dazu wird eine switch-case genutzt.
  
  
 
  
  
  
  //Zum Beispiel nur die Anzeige innerhalb von Processing, die Ausgabe via SPout oder der Videoexport.
  //Eine Wahl aus mehreren Optionen ist ebenfalls möglich.
  //time = (millis()/1000)%60;
   //fCount+=1;
  //Optionally resize the window to match the sender
  //spout.resizeFrame();
  //text(""+infoDisplay, 50, 50);
  //text(""+time, 50, 70); 
  //text(""+tresholdDef, 50, 160); 
  text(""+infoFilter, 50, 120);
  text(""+ infowbControl, 50, 140);
  //text(""+fCount, 50, 90);
  text(frameRate, 50, 30);
  //text(""+sprungDef, 50, 200);
  //text(""+colorFreQ,50,220);
  //text(""+freq,50,240);
}
