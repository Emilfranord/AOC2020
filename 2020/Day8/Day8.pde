String[] inp;

void setup() {
  inp = loadStrings("input.txt");
  println("Part one:"+interpBoot(inp));
  print("Part two:");cycleFlips(inp);
}

void cycleFlips(String[] inp){
  for(int i = 0; i<inp.length; i++){
    
    inp[i] = flipInstruction(inp[i]);
    interpBoot(inp);
    inp[i] = flipInstruction(inp[i]);
  }
}

int interpBoot(String[] inp) {
  boolean[] seen = new boolean[inp.length];
  for (boolean q : seen) {
    q = false;
  }
  int acc = 0;

  for (int i =0; i<inp.length; i++) { // might remove i++

    if (seen[i]) {// seen
      //println("infLoop:"+i);
      return acc;
    }
    seen[i] = true;

    if (inp[i].contains("acc")) {//acc
      String sub = inp[i].substring(4);
      int temp = Integer.parseInt(sub);
      acc+=temp;
    }

    if (inp[i].contains("noc")) {//noc
    }

    if (inp[i].contains("jmp")) {//jmp
      String sub = inp[i].substring(4);
      int temp = Integer.parseInt(sub);
      i+=temp;
      i--;
    }
  }

  print(acc);
  return acc;
} 

String flipInstruction(String inp) {
  if (inp.contains("nop")) {
    StringBuilder myString = new StringBuilder(inp);
    myString.setCharAt(0, 'j');
    myString.setCharAt(1, 'm');
    return myString.toString();
  }

  if (inp.contains("jmp")) {
    StringBuilder myString = new StringBuilder(inp);
    myString.setCharAt(0, 'n');
    myString.setCharAt(1, 'o');
    return myString.toString();
  }

  return inp;
}
