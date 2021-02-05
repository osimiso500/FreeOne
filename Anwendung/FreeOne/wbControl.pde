//Die Methode wird benutzt um exkludierte Bereiche schwarz einzufärben oder um die Berechnung komplett auszusetzen.
//Es besteht die Möglichekit die Bereiche zu invertieren. Eine simple Methode um...

void wbControl() {  
  
  switch((int)wbControl) {

  case 1: 

    for (int sP = 0; sP < img.pixels.length; sP++) {
        if (img.pixels[sP] == color(0,0,0)) { //RGB Kanäle auf 0 prüfen
          imgEx.pixels[sP] = color(0, 0, 0); //RGB Kanäle mit 0 überschreiben
        }
      }
    break;
  case 2:
      for (int sP = 0; sP < img.pixels.length; sP++) {
        if (img.pixels[sP] == color(255,255,255)) {  //RGB Kanäle auf 255 prüfen
          imgEx.pixels[sP] = color(0, 0, 0); //RGB Kanäle mit 0 überschreiben
        }
      }
    break;
  case 3: 
    //print("WB is off");
    break;
  }
}
