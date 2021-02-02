//Die Methode wird benutzt um exkludierte Bereiche schwarz einzufärben oder um die Berechnung komplett auszusetzen.
//Es besteht die Möglichekit die Bereiche zu invertieren. Eine simple Methode um...

void wbControl() {  
  
  switch((int)wbControl) {

  case 1: 

    for (int sP = 0; sP < img.pixels.length; sP++) {
        if (img.pixels[sP] == color(0,0,0)) { //alle kanäle  auf 0 prüfen ausser alpha
          imgEx.pixels[sP] = color(0, 0, 0); //alle kanäle mit 0 überschreiben ausser alpha
        }
      }
    break;
  case 2:
      for (int sP = 0; sP < img.pixels.length; sP++) {
        if (img.pixels[sP] == color(255,255,255)) {  //alle kanäle auf 0 prüfen ausser alpha
          imgEx.pixels[sP] = color(0, 0, 0); //alle kanäle mit 0 überschreiben ausser alpha
        }
      }
    break;
  case 3: 
    //print("WB is off");
    break;
  }
}
