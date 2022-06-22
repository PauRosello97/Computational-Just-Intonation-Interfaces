void mousePressed() {
  for (Tone[] row : tones) for (Tone tone : row) tone.mousePressed();
}

void keyPressed() {
  switch(keyCode) {
    /* Arrows */
  case 37:
    previousScale();
    break;
  case 38:
    nextMode();
    break;
  case 39:
    nextScale();
    break;
  case 40:
    previousMode();
    break;
  /* Piano */
  default:
    playNote(keyCode);
  }
}

void nextScale() {
  selectedScale = (selectedScale+1)%nVariations;
  setScale();
}

void previousScale() {
  selectedScale--;
  if (selectedScale<0) selectedScale = nVariations-1;
  setScale();
}

void nextMode() {
  selectedMode = (selectedMode+1)%whiteTones;
  setScale();
}

void previousMode() {
  selectedMode--;
  if (selectedMode<0) selectedMode = whiteTones-1;
  setScale();
}
