import java.util.Collections;

String[] inp;

void setup() {
  inp = loadStrings("input.txt");
  int[] in = listInt(inp);
  println(adapter(in));
}

int [] listInt(String[] inp) {
  int[] temp = new int [inp.length];  

  for (int i = 0; i<inp.length; i++) {
    temp[i] = Integer.parseInt(inp[i], 10);
  }
  return temp;
}



int adapter(int[] inp) {
  inp = sort(inp);
  int diffOne = 0;
  int diffThree =0;

  int lower = 0;
  int devise = 3+ max(inp);


  println();

  if (inp[0]-lower == 3) {
    diffThree++;
  }
  if (inp[0]-lower == 1) {
    diffOne++;
  }

  for (int i = 0; i<inp.length-1; i++) {
    println(inp[i+1]-inp[i]);

    if (inp[i+1]-inp[i] == 3) {
      diffThree++;
    }
    if (inp[i+1]-inp[i] == 1) {
      diffOne++;
    }
  }
  diffThree++; // the last adapter to the device. 



  println(diffOne, diffThree);
  return diffOne * diffThree;
}
