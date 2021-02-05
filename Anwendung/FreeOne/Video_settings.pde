//Diese Methode beschäftigt sich vorwiegend mit den Möglichkeiten des Videoexports durch FFMPG
//Es können verschiedene Parameter festgelegt werden.

void videosettings()
{  
  videoActive = true;   
  String dateTime = day()+"_"+month()+"_"+year()+"_"+ hour() + "h" + minute() + "m" + second() + "s";
  //erzeugt einen eindeutigen Namen der Videodatei.
  String outputname = dateTime;
  //Name der Videodatei wird übergeben.
  String size="1280x720";
  //Diese Variable kann genutzt werden um die Ausgabeauslösung zu verändern. 
  String ffmpegFrameRate = "25";
  //Diese Variable kann genutzt werden um die Ausgabe FPS zu verändern.
  
  if(sketchFPS == 20){
    ffmpegFrameRate = "20";
  }
  else if(sketchFPS == 25){
    ffmpegFrameRate = "25";
  }
  else if(sketchFPS == 30){
    ffmpegFrameRate = "30";
  }
  else if(sketchFPS == 50){
    ffmpegFrameRate ="50";
  }
  else if(sketchFPS == 60){
    ffmpegFrameRate = "60";
  }
  
  //Create A NEW VIDEOEXPORT OBJECT
  videoExport = new VideoExport(this, outputname+".mov");

  //set different parameters for ffmpeg export
  videoExport.setFfmpegVideoSettings(
    new String[]{
    "[ffmpeg]", // ffmpeg executable
    "-f", "rawvideo", // format rgb raw
    "-s", size, // size
    "-pix_fmt", "rgb24", // pix format rgb24
    "-r", ffmpegFrameRate, // frame rate
    "-i", "-", // pipe input

    "-an", // no audioq
    "-vcodec", "prores", // out codec prores_ks //rawvideo
    "-profile:","2",
    "-pix_fmt", "yuv422p10le", // color space yuv422p10le //rgb24*/
    "-metadata", "comment=[FreeOne]", // comment
    "[output]"                        // output file
    });
  //set the FrameRate of the Export for better performance
  //videoExport.setFrameRate(30);
}

//Die Funktion gibt eine Aussage zurück darüber, ob eine Video-Aufzeichnung gestartet worden ist oder nicht.
Boolean wasVideoactive() {
  return videoActive;
}

//Die Funktion prfüt ob in der Aktuellen Session schon eine Video-Aufzeichnung erfolgt ist
void exitVideoOrNot() {
  if (videoActive){
    videoActive = false;
    videoExport.endMovie();
  }
}

void setFramerate(){
  if(setFPS.equals("25")){
    setFPSdyn[0] = "eins";
    saveStrings("fps.txt", setFPSdyn);
  }
  else if(setFPS.equals("30")){
    setFPSdyn[0] = "zwei";
    saveStrings("fps.txt", setFPSdyn);
  }
  else if(setFPS.equals("50")){
    setFPSdyn[0] = "drei";
    saveStrings("fps.txt", setFPSdyn);
  }
  else if(setFPS.equals("60")){
    setFPSdyn[0] = "vier";
    saveStrings("fps.txt", setFPSdyn);
  }
  else if(setFPS.equals("20")){
    setFPSdyn[0] = "fünf";
    saveStrings("fps.txt", setFPSdyn);
  }
  else{
    setFPSdyn[0] = "eins";
    saveStrings("fps.txt", setFPSdyn);
  }
}
