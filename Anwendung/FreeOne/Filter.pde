//In dieser Methode werden Filter zur Verfügung gestellt, diese Filter sollen die von Resolume gesendeten 
//Daten verarbeiten und dort wo es möglich ist auch interaktiv verändert werden könnnen.

void selectFilter()
{
  switch(whichFilter) {

  case 1:  //Threshold
    img.filter(THRESHOLD, tresholdDef);
    break;
    case 2:  //OWN+COLORPIXEL
    if(freq>=(int)colorFreQ)
          {
              a = random(255);
              b = random(255);
              c = random(255);
              colorWert1 = random(10,230);
              freq=0;;
          }
    else{
      freq++;
    }
    
    for (int sP = 0; sP < imgEx.pixels.length; sP++) {//immer nach einer bestimmten Zeit werden die Schwellenerte verändern
        if (red(imgEx.pixels[sP]) <= (int)colorWert1) {//immer nach einer gewissen Zeit werden eine neue random farbe erzeugen  
          imgEx.pixels[sP]=color(a,b,c);
        }
      }
      zeilensprung+= (int)sprungDef;
    for (int x = 0; x < imgEx.width; x++) {
      for (int y = zeilensprung; y < zeilensprung+30; y++) {
        imgEx.pixels[y*width+x] = #000000;
        imgEx.pixels[(y+50)*width+x] = #000000;
        imgEx.pixels[(y+100)*width+x] = #000000;
        imgEx.pixels[(y+150)*width+x] = #000000;
        imgEx.pixels[(y+200)*width+x] = #000000;
        imgEx.pixels[(y+250)*width+x] = #000000;
        imgEx.pixels[(y+300)*width+x] = #000000;
        imgEx.pixels[(y+350)*width+x] = #000000;
        imgEx.pixels[(y+400)*width+x] = #000000;
        imgEx.pixels[(y+450)*width+x] = #000000;
        imgEx.pixels[(y+500)*width+x] = #000000;
        imgEx.pixels[(y+550)*width+x] = #000000;
        imgEx.pixels[(y+600)*width+x] = #000000;
        imgEx.pixels[(y+650)*width+x] = #000000;
        if (y >= 69) {
          zeilensprung=0;
        }
      }
    }
    break;
   case 3: //COLORPIXEL
    if(freq>=(int)colorFreQ)
          {
              a = random(255);
              b = random(255);
              c = random(255);
              colorWert1 = random(10,230);
              freq=0;;
          }
    else{
      freq++;
    }
    
    for (int sP = 0; sP < imgEx.pixels.length; sP++) {//immer nach einer bestimmten Zeit werden die Schwellenerte verändern
        if (red(imgEx.pixels[sP]) <= (int)colorWert1) {//immer nach einer gewissen Zeit werden eine neue random farbe erzeugen  
          imgEx.pixels[sP]=color(a,b,c);
        }
      }
      zeilensprung+= (int)sprungDef;
    break;
   case 4:  //OWN
    zeilensprung+= (int)sprungDef;
    for (int x = 0; x < imgEx.width; x++) {
      for (int y = zeilensprung; y < zeilensprung+30; y++) {
        imgEx.pixels[y*width+x] = #000000;
        imgEx.pixels[(y+50)*width+x] = #000000;
        imgEx.pixels[(y+100)*width+x] = #000000;
        imgEx.pixels[(y+150)*width+x] = #000000;
        imgEx.pixels[(y+200)*width+x] = #000000;
        imgEx.pixels[(y+250)*width+x] = #000000;
        imgEx.pixels[(y+300)*width+x] = #000000;
        imgEx.pixels[(y+350)*width+x] = #000000;
        imgEx.pixels[(y+400)*width+x] = #000000;
        imgEx.pixels[(y+450)*width+x] = #000000;
        imgEx.pixels[(y+500)*width+x] = #000000;
        imgEx.pixels[(y+550)*width+x] = #000000;
        imgEx.pixels[(y+600)*width+x] = #000000;
        imgEx.pixels[(y+650)*width+x] = #000000;
        if (y >= 69) {
          zeilensprung=0;
        }
      }
    }
    break;
    case 5:
    break;
  }
}
