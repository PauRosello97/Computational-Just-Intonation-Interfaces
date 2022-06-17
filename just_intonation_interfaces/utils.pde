// Count repetitions in ArrayList of tones

boolean anyRepeated(ArrayList<Integer> tones){
  int[] counter = new int[et];
  for(int tone : tones){
    counter[tone]++;
    if(counter[tone]>1) return true;
  }
  return false;
}
