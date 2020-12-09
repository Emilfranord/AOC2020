import java.util.*;

String[] inp;


void setup() {
  inp = loadStrings("input.txt");
  long [] inpPrime = listInt(inp);
  println(fitstFailure(inpPrime, 25));
}


long [] listInt(String[] inp) {
  long[] temp = new long [inp.length];  

  for (int i = 0; i<inp.length; i++) {
    temp[i] = Long.parseLong(inp[i], 10);
  }
  return temp;
}




long  fitstFailure(long [] inp, int preamble) {


  for (int  i = preamble; i<inp.length; i++) { // 24 might be wrong;
    if (!sumPossible(Arrays.copyOfRange(inp, i-preamble, i), inp[i])) {
      return inp[i];
    }
  }
  return -1;
}



boolean sumPossible(long [] per, long  goal) {
  for (int i = 0; i<per.length; i++) {
    long  friend = goal - per[i];
    if (contains(per, friend)) {
      return true;
    }
  }
  return false;
}

boolean contains(long [] input, long  search ) {
  for (long  q : input) {
    if (q == search) {
      return true;
    }
  }

  return false;
}



//long weakness(long[] inp){
//  long goal = fitstFailure(inp, 25);
  
//  does inp[i] + inp[i+1] = goal, for all i? no
//  does .... + inp[i+2] = goal, for all i ? no
  
  
  

//}
