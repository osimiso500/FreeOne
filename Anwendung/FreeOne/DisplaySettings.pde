//DisplaySettings beschäftigt sich mit der Möglichkeit in verschiedenen Modis Ausgaben in Processing zu machen.

void setDisplayOptions() {
  switch(displaySettings) {
  case 1: 
    image(img, 0, 0, width, height);
    break;
  case 2: 
    image(imgEx, 0, 0, width, height);
    spoutSend.sendTexture(imgEx);
    spoutSend2.sendTexture(imgEx);
    break;
  case 3:
    image(imgEx, 0, 0, width, height);
    videoExport.setGraphics(imgEx);
    videoExport.saveFrame(); //export video
    spoutSend.sendTexture(imgEx);
    spoutSend2.sendTexture(imgEx);
    break;
  }
}
