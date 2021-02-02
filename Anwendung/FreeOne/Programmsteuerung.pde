//Die Programmsteuerung ist vorwiegend als Debug und Test Konstrukt gedacht.
// Alle Optionen, welche hier gewählt werden können sollten auch später über Resolume zur Verfügung stehen.

//mit einem Rechtsklick im Fenster kann ein Sender gewählt werden
void mousePressed() {
  if (mouseButton == RIGHT) {

    spout.selectSender();
  }
}

//verschiedene Kommandos zum entwickeln der Anwendung.
void keyPressed() {
  if (key == 'q') {
    exitVideoOrNot();
    exit();
  } else if (key == 'u') {
    tresholdDef+=0.1;
  } else if (key == 'd') {
    tresholdDef-=0.1;
  } else if (key == '1') {
    infowbControl = "WBControl Mode 1 is on";
    wbControl = 1;
  } else if (key == '2') {
    infowbControl = "WBControl Mode 2 is on";
    wbControl = 2;
  } else if (key == '3') {
    infowbControl = "WBControl is off";
    wbControl = 3;
  } else if (key == 'a') {
    displaySettings = 1;
    infoDisplay = "Image is on";
    exitVideoOrNot();
  } else if (key == 's') {
    displaySettings = 2;
    infoDisplay = "SpoutSender is on";
    exitVideoOrNot();
  } else if (key == 'v') {
    videosettings();
    displaySettings = 3;
    infoDisplay = "videoexport is on";
    //start the Video Export
    videoExport.startMovie();
  } else if (key == '7') {
    infoFilter="THRESHOLD is on";
    whichFilter = 1;
  } else if (key == '9') {
    infoFilter="OWN is on";
    whichFilter = 4;
  } else if (key == '0') {
    infoFilter="COLORPIXEL is on";
    whichFilter = 3;
  } else if (key == '8') {
    infoFilter="OWN+COLORPIXEL is on";
    whichFilter = 2;
    tempfCount=fCount;
  }
  else if (key == '+'){
    sprungDef+=1;
  }
  else if (key == '-'){
    sprungDef-=1;
  }
  else if (key == ','){
    posterDef+=1;
  }
  else if (key == '.'){
    posterDef-=1;
  }
  else if (key == 'y'){
    setFPSdyn[0] = "drei";
    saveStrings("fps.txt", setFPSdyn);
  }
}
